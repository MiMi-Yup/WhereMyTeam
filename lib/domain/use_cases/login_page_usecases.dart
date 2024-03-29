import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/data/data_source/remote/cloud_storage_service.dart';
import 'package:wmteam/data/data_source/remote/firebase_auth_service.dart';
import 'package:wmteam/domain/repositories/unit_of_work.dart';
import 'package:wmteam/domain/use_cases/team_usecases.dart';
import 'package:wmteam/models/model_user.dart';

@injectable
class LoginUseCases {
  final UnitOfWork unitOfWork;
  final FirebaseAuthService authService;
  final TeamUseCases teamUsercase;

  LoginUseCases(
      {required this.unitOfWork,
      required this.authService,
      required this.teamUsercase});

  Future<ModelUser?> loginPassword(String email, String password,
      {bool remember = false}) async {
    try {
      UserCredential? credential = await unitOfWork.auth
          .loginByPassword(email: email, password: password);
      // await _initFirestore(credential);
      if (credential != null) {
        if (remember) {
          unitOfWork.preferences.setToken(email: email, password: password);
        }

        return ModelUser(
            id: credential.user?.uid, email: credential.user?.email);
      }
    } on FirebaseException {
      return null;
    }
    return null;
  }

  Future<ModelUser?> loginGoogle({bool remember = false}) async {
    try {
      UserCredential? credential = await unitOfWork.auth.loginByGoogle();
      // await _initFirestore(credential);
      if (credential != null) {
        if (remember && credential.credential != null) {
          unitOfWork.preferences.setToken(
              accessToken: credential.credential!.accessToken,
              idToken: credential.credential!.token);
        }
        return ModelUser(
            id: credential.user?.uid, email: credential.user?.email);
      }
    } on FirebaseException {
      return null;
    }
    return null;
  }

  Future<ModelUser?> signUpPassword(
      String name, String email, String password) async {
    try {
      UserCredential? credential = await unitOfWork.auth
          .signUpByPassword(email: email, password: password);
      // await _initFirestore(credential);
      await credential?.user?.updateDisplayName(name);
      if (credential != null) {
        return ModelUser(
            id: credential.user?.uid,
            email: credential.user?.email,
            name: credential.user?.displayName,
            phoneNumber: credential.user?.phoneNumber);
      }
    } on FirebaseException {
      return null;
    }
    return null;
  }

  Future<ModelUser?> loginRemember() async {
    Map<String, dynamic>? token = await unitOfWork.preferences.getToken();
    if (token == null) return null;
    late AuthCredential credential;
    switch (token['type']) {
      case 'email':
        credential = EmailAuthProvider.credential(
            email: token['email'], password: token['password']);
        break;
      // case 'google':
      //   credential = GoogleAuthProvider.credential(
      //       accessToken: token['accessToken'], idToken: token['idToken'].toString());
      //   break;
      default:
        return null;
    }
    UserCredential resultCredential =
        await authService.service.signInWithCredential(credential);
    // await _initFirestore(resultCredential);
    return resultCredential.user == null
        ? null
        : ModelUser(
            id: resultCredential.user?.uid,
            email: resultCredential.user?.email);
  }

  Future<void> signOut() async {
    await unitOfWork.auth.signOut();
    await unitOfWork.preferences.clear();
  }

  Future<bool> checkAlreadyUser(String uid) async {
    final check = await unitOfWork.user.getRefById(uid).get();
    return check.exists;
  }

  Future<bool> initUser(ModelUser? user) async {
    if (user != null &&
        !await checkAlreadyUser(user.id!) &&
        user.avatar?.isNotEmpty == true) {
      final avatar = user.avatar;
      user.avatar = 'avatar/${user.id}/image.png';
      await CloudStorageService.uploadFile(File(avatar!), user.avatar!);

      await unitOfWork.user.insert(user);
      await teamUsercase.createTeam(
          isFamilyTeam: true, name: 'Family', avatar: avatar);
    }
    return false;
  }
}
