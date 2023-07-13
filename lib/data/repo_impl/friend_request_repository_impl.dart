import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/data/data_source/remote/firebase_auth_service.dart';
import 'package:wmteam/data/data_source/remote/firestore_service.dart';
import 'package:wmteam/domain/repositories/friend_request_repository.dart';
import 'package:wmteam/domain/repositories/location_repository.dart';
import 'package:wmteam/domain/repositories/user_repository.dart';
import 'package:wmteam/models/model_friend_request.dart';
import 'package:wmteam/models/model_user.dart';
import 'package:wmteam/models/model.dart';

@Injectable(as: FriendRequestRepository)
class FriendRequestRepositoryImpl extends FriendRequestRepository {
  final FirebaseAuthService auth;
  final FirestoreService firestore;
  final UserRepository userRepo;

  FriendRequestRepositoryImpl(
      {required this.firestore, required this.auth, required this.userRepo});

  @override
  Future<void> delete(IModel model) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  FirebaseFirestore get firestoreService => firestore.service;

  @override
  Future<ModelUser?> getModelByRef(DocumentReference<Object?> ref) async {
    DocumentSnapshot<ModelUser> snapshot = await ref
        .withConverter(
            fromFirestore: ModelUser.fromFirestore,
            toFirestore: (ModelUser model, _) => model.toFirestore())
        .get();
    return snapshot.exists ? snapshot.data() : null;
  }

  @override
  String getPath(String? uid) => '/friend_request';

  @override
  Future<List<IModel>?> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  User? get user => auth.service.currentUser;

  @override
  Future<List<ModelFriendRequest>?> getRequests() async {
    final snapshot = await firestoreService
        .collection(getPath(null))
        .withConverter(
            fromFirestore: ModelFriendRequest.fromFirestore,
            toFirestore: (ModelFriendRequest model, _) => model.toFirestore())
        .where('receiver', isEqualTo: userRepo.getRefById(user!.uid))
        .get();
    return snapshot.size > 0
        ? snapshot.docs.map((e) => e.data()).toList()
        : null;
  }

  @override
  Future<bool?> makeAccept({required String idUser}) async {
    ModelUser? user = await userRepo.getCurrentUser();
    if (user?.id == null) return false;
    final query = await _search(senderId: idUser, receiverId: user!.id!);
    if (query.size == 1) {
      await firestoreService
          .doc('${getPath(null)}/${query.docs.first.id}')
          .delete();
      await Future.wait([
        userRepo.addFriend(ownerUserId: user.id!, userId: idUser),
        userRepo.addFriend(ownerUserId: idUser, userId: user.id!)
      ]);
      return true;
    }
    return false;
  }

  @override
  Future<bool?> makeDenied({required String idUser}) async {
    ModelUser? user = await userRepo.getCurrentUser();
    if (user?.id == null) return false;
    final query = await _search(senderId: idUser, receiverId: user!.id!);
    if (query.size == 1) {
      await firestoreService
          .doc('${getPath(null)}/${query.docs.first.id}')
          .delete();
      return true;
    }
    return false;
  }

  Future<QuerySnapshot<ModelFriendRequest>> _search(
      {required String senderId, required String receiverId}) async {
    return firestoreService
        .collection(getPath(null))
        .withConverter(
            fromFirestore: ModelFriendRequest.fromFirestore,
            toFirestore: (ModelFriendRequest model, _) => model.toFirestore())
        .where('sender', isEqualTo: userRepo.getRefById(senderId))
        .where('receiver', isEqualTo: userRepo.getRefById(receiverId))
        .get();
  }

  @override
  Future<bool?> makeRequest({required String idUser}) async {
    try {
      ModelUser? user = await userRepo.getCurrentUser();
      if (user?.id == null) return false;
      final query = await _search(senderId: user!.id!, receiverId: idUser);
      if (query.size > 0) return false;
      firestoreService
          .collection(getPath(null))
          .withConverter(
              fromFirestore: ModelFriendRequest.fromFirestore,
              toFirestore: (ModelFriendRequest model, _) => model.toFirestore())
          .add(ModelFriendRequest(
              id: null,
              sender: userRepo.getRefById(user.id!),
              receiver: userRepo.getRefById(idUser),
              status: false));
      return true;
    } on Exception {
      return false;
    }
  }
}
