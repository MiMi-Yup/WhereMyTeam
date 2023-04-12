import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/data/data_source/remote/firebase_auth_service.dart';
import 'package:where_my_team/data/data_source/remote/firestore_service.dart';
import 'package:where_my_team/domain/repositories/route_repository.dart';
import 'package:where_my_team/models/model_route.dart';
import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/models/model.dart';

@Injectable(as: RouteRepository)
class RouteRepositoryImpl extends RouteRepository {
  final FirestoreService firestore;
  final FirebaseAuthService auth;

  RouteRepositoryImpl({required this.firestore, required this.auth});

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
  Future<bool> deleteRoute({required IModel model}) async {
    try {
      await delete(model);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  FirebaseFirestore get firestoreService => firestore.service;

  @override
  String getPath(String? uid) => '/user/$uid/route';

  @override
  Future<ModelRoute?> getRoute({required String id}) {
    return getModelByRef(getRefById(id));
  }

  @override
  Future<List<ModelRoute>?> getRoutes() async {
    QuerySnapshot<ModelRoute> snapshot = await firestore.service
        .collection(getPath(user?.uid))
        .withConverter(
            fromFirestore: ModelRoute.fromFirestore,
            toFirestore: (ModelRoute model, _) => model.toFirestore())
        .get();
    return snapshot.size > 0
        ? snapshot.docs.map((e) => e.data()).toList()
        : null;
  }

  @override
  Future<ModelRoute?> postRoute({required ModelRoute newRoute}) async {
    await insert(newRoute);
    return null;
  }

  @override
  Future<bool> putRouteShare({required String id, required bool state}) async {
    ModelRoute? model = await getModelByRef(getRefById(id));
    if (model != null) {
      await update(model, model.copyWith(isShared: state));
      return true;
    }
    return false;
  }

  @override
  Future<List<ModelRoute>?> read() async {
    try {
      QuerySnapshot<ModelRoute> snapshot = await firestore.service
          .collection(getPath(user?.uid))
          .withConverter(
              fromFirestore: ModelRoute.fromFirestore,
              toFirestore: (ModelRoute model, _) => model.toFirestore())
          .get();
      return snapshot.docs.map((e) => e.data()).toList();
    } on FirebaseException {
      return null;
    }
  }

  @override
  User? get user => auth.service.currentUser;

  @override
  Future<ModelRoute?> getModelByRef(DocumentReference<Object?> ref) async {
    try {
      DocumentSnapshot<ModelRoute> snapshot = await ref
          .withConverter(
              fromFirestore: ModelRoute.fromFirestore,
              toFirestore: (ModelRoute model, _) => model.toFirestore())
          .get();
      return snapshot.data();
    } on FirebaseException {
      return null;
    }
  }
}
