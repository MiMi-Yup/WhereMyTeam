import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:where_my_team/data/data_source/remote/firebase_auth_service.dart';
import 'package:where_my_team/data/data_source/remote/firestore_service.dart';
import 'package:where_my_team/domain/repositories/location_repository.dart';
import 'package:where_my_team/domain/repositories/route_repository.dart';
import 'package:where_my_team/models/model.dart';
import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/models/model_route.dart';

@Injectable(as: LocationRepository)
class LocationRepositoryImpl extends LocationRepository {
  final FirestoreService firestore;
  final FirebaseAuthService auth;
  final RouteRepository routeRepo;
  LocationRepositoryImpl(
      {required this.firestore, required this.auth, required this.routeRepo});

  @override
  Future<void> delete(IModel model) {
    if (model is! ModelLocation) {
      throw ArgumentError('Request ModelTransaction');
    }

    return firestore.service
        .collection(getPath(user?.uid))
        .doc(model.id)
        .delete();
  }

  @override
  FirebaseFirestore get firestoreService => firestore.service;

  @override
  Future<ModelLocation?> getModelByRef(DocumentReference<Object?> ref) async {
    try {
      DocumentSnapshot<ModelLocation> snapshot = await ref
          .withConverter(
              fromFirestore: ModelLocation.fromFirestore,
              toFirestore: (ModelLocation model, _) => model.toFirestore())
          .get();
      return snapshot.exists ? snapshot.data() : null;
    } on FirebaseException {
      return null;
    }
  }

  @override
  User? get user => auth.service.currentUser;

  @override
  String getPath(String? uid) => '/user/$uid/location';

  @override
  Future<void> insert(IModel model) {
    return firestore.service
        .collection(getPath(user?.uid))
        .doc(model.id)
        .set(model.toFirestore());
  }

  @override
  Future<List<ModelLocation>?> read() async {
    try {
      QuerySnapshot<ModelLocation> snapshot = await firestore.service
          .collection(getPath(user?.uid))
          .withConverter(
              fromFirestore: ModelLocation.fromFirestore,
              toFirestore: (ModelLocation model, _) => model.toFirestore())
          .get();
      return snapshot.docs.map((e) => e.data()).toList();
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<ModelLocation?> getLocation({required String id}) {
    return getModelByRef(getRefById(id));
  }

  @override
  Future<List<ModelLocation>?> getDetailRoute(ModelRoute model) async {
    try {
      QuerySnapshot<ModelLocation> snapshot = await firestore.service
          .collection(getPath(model.user!.id))
          .where("route",
              isEqualTo: routeRepo.getRefEx(
                  idUser: model.user!.id, idRouter: model.id!))
          .withConverter(
              fromFirestore: ModelLocation.fromFirestore,
              toFirestore: (ModelLocation model, _) => model.toFirestore())
          .get();
      return snapshot.docs.map((e) => e.data()).toList();
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
