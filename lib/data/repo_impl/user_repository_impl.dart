import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/data/data_source/remote/firebase_auth_service.dart';
import 'package:where_my_team/data/data_source/remote/firestore_service.dart';
import 'package:where_my_team/domain/repositories/location_repository.dart';
import 'package:where_my_team/domain/repositories/user_repository.dart';
import 'package:where_my_team/models/model_team_user.dart';
import 'package:where_my_team/models/model_user.dart';
import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/models/model.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final FirebaseAuthService auth;
  final FirestoreService firestore;
  final LocationRepository locationRepo;
  UserRepositoryImpl(
      {required this.firestore,
      required this.auth,
      required this.locationRepo});

  @override
  Future<void> delete(IModel model) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  FirebaseFirestore get firestoreService => firestore.service;

  @override
  Future<ModelUser?> getCurrentUser() {
    return user?.uid == null
        ? Future.value(null)
        : getModelByRef(getRefById(user!.uid));
  }

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
  String getPath(String? uid) => '/user';

  @override
  Future<void> postUserInitial() {
    return insert(ModelUser(
        id: user?.uid,
        email: user?.email,
        name: user?.displayName,
        phoneNumber: user?.phoneNumber,
        avatar: user?.photoURL));
  }

  @override
  Future<bool> putFreezeLocation({required bool state}) async {
    final ModelUser? _user =
        user != null ? await getModelByRef(getRefById(user!.uid)) : null;
    if (_user != null) {
      await update(_user, _user.copyWith(freezeLocation: state));
      return true;
    }
    return false;
  }

  @override
  Future<bool> putLastLocation({required ModelLocation lastLocation}) async {
    DocumentReference locationRef = locationRepo.getRef(lastLocation);
    final ModelUser? _user =
        user != null ? await getModelByRef(getRefById(user!.uid)) : null;
    if (_user != null) {
      await update(_user, _user.copyWith(lastLocation: locationRef));
      return true;
    }
    return false;
  }

  @override
  Future<bool> putShareNotification({required bool state}) async {
    final ModelUser? _user =
        user != null ? await getModelByRef(getRefById(user!.uid)) : null;
    if (_user != null) {
      await update(_user, _user.copyWith(shareNotification: state));
      return true;
    }
    return false;
  }

  @override
  Future<List<IModel>?> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  User? get user => auth.service.currentUser;

  @override
  Future<bool> putBattery({required int level}) async {
    ModelUser? user = await getCurrentUser();
    if (user != null && user.percentBatteryDevice != level) {
      await update(user, user.copyWith(percentBatteryDevice: level));
      return true;
    }
    return false;
  }

  @override
  Future<bool> putAvatar({required String path}) async {
    ModelUser? user = await getCurrentUser();
    if (user != null) {
      await update(user, user.copyWith(avatar: path));
      return true;
    }
    return false;
  }

  @override
  Future<bool> putUserInitial(
      {required String phoneNumber, String? avatar, String? name}) async {
    ModelUser? user = await getCurrentUser();
    if (user != null) {
      await update(user,
          user.copyWith(avatar: avatar, phoneNumber: phoneNumber, name: name));
      return true;
    }
    return false;
  }

  @override
  Future<ModelUser?> getUser({required String userId}) {
    return getModelByRef(getRefById(userId));
  }

  @override
  Future<List<ModelUser>?> getUsers() async {
    QuerySnapshot<ModelUser> query = await firestoreService
        .collection(getPath(null))
        .withConverter(
            fromFirestore: ModelUser.fromFirestore,
            toFirestore: (ModelUser model, _) => model.toFirestore())
        .get();

    return query.size > 0 ? query.docs.map((e) => e.data()).toList() : null;
  }

  @override
  Future<ModelTeamUser?> getFamilyTeam() async {
    final teamQuery = await firestoreService
        .collection('team')
        .where('isFamilyTeam', isEqualTo: true)
        .get();
    final userQuery = firestoreService
        .collection('${getPath(null)}/${user?.uid}/team')
        .where(FieldPath.documentId, whereIn: [
      for (final doc in teamQuery.docs) doc.id
    ]).withConverter(
            fromFirestore: ModelTeamUser.fromFirestore,
            toFirestore: (ModelTeamUser model, _) => model.toFirestore());
    final teamDoc = await userQuery.get();
    if (teamDoc.size == 1) return teamDoc.docs.first.data();
    return null;
  }

  @override
  Stream<DocumentSnapshot<ModelUser>> snapshot({required String userId}) {
    return firestoreService
        .doc('${getPath(null)}/$userId')
        .withConverter(
            fromFirestore: ModelUser.fromFirestore,
            toFirestore: (ModelUser model, _) => model.toFirestore())
        .snapshots(includeMetadataChanges: true);
  }
}
