import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/data/data_source/remote/firebase_auth_service.dart';
import 'package:wmteam/data/data_source/remote/firestore_service.dart';
import 'package:wmteam/domain/repositories/route_repository.dart';
import 'package:wmteam/models/model_route.dart';
import 'package:wmteam/models/model_location.dart';
import 'package:wmteam/models/model.dart';
import 'package:wmteam/models/model_user.dart';

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
  Future<List<ModelRoute>?> getRoutes({String? id}) async {
    late QuerySnapshot<ModelRoute> snapshot;
    if (id == null || user?.uid == id) {
      snapshot = await firestore.service
          .collection(getPath(user?.uid))
          .withConverter(
              fromFirestore: ModelRoute.fromFirestore,
              toFirestore: (ModelRoute model, _) => model.toFirestore())
          .get();
    } else {
      snapshot = await firestore.service
          .collection(getPath(id))
          .where('isShared', isEqualTo: true)
          .withConverter(
              fromFirestore: ModelRoute.fromFirestore,
              toFirestore: (ModelRoute model, _) => model.toFirestore())
          .get();
    }
    return snapshot.size > 0
        ? snapshot.docs.map((e) => e.data()).toList()
        : null;
  }

  @override
  Future<void> insert(IModel model) async {
    DocumentReference ref = await firestore.service
        .collection(getPath(user?.uid))
        .withConverter(
            fromFirestore: ModelRoute.fromFirestore,
            toFirestore: (ModelRoute model, _) => model.toFirestore())
        .add(model as ModelRoute);
    model.id = ref.id;
  }

  @override
  Future<ModelRoute?> postRoute({required ModelRoute newRoute}) async {
    await insert(newRoute);
    return newRoute;
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

  @override
  DocumentReference<Map<String, dynamic>> getRefEx(
      {required String idUser, required String idRouter}) {
    return firestoreService.collection(getPath(idUser)).doc(idRouter);
  }
}
