import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/data/data_source/remote/firebase_auth_service.dart';
import 'package:where_my_team/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService authService;

  AuthRepositoryImpl({required this.authService});

  @override
  Future<UserCredential?> loginByGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return null;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await authService.service.signInWithCredential(credential);
  }

  @override
  Future<bool> signOut() async {
    await authService.service.signOut();
    await GoogleSignIn().signOut();
    return true;
  }

  @override
  Future<UserCredential?> loginByPassword(
      {required String email, required String password}) {
    return authService.service
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<UserCredential?> signUpByPassword(
      {required String email, required String password}) {
    return authService.service.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential?> loginByCredentail(
      {required AuthCredential credential}) {
    return authService.service.signInWithCredential(credential);
  }
}
