import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/data/data_source/remote/firebase_auth_service.dart';
import 'package:wmteam/data/data_source/remote/firestore_service.dart';
import 'package:wmteam/domain/repositories/type_route_repository.dart';
import 'package:wmteam/models/model.dart';
import 'package:wmteam/models/model_type_route.dart';

@Injectable(as: TypeRouteRepository)
class TypeRouteRepositoryImpl extends TypeRouteRepository {
  final FirestoreService firestore;
  final FirebaseAuthService authService;

  TypeRouteRepositoryImpl({required this.firestore, required this.authService});

  @override
  Future<void> delete(IModel model) {
    return Future.value();
  }

  @override
  FirebaseFirestore get firestoreService => firestore.service;

  @override
  Future<ModelTypeRoute?> getModelByRef(DocumentReference<Object?> ref) async {
    try {
      DocumentSnapshot<ModelTypeRoute> snapshot = await ref
          .withConverter(
              fromFirestore: ModelTypeRoute.fromFirestore,
              toFirestore: (ModelTypeRoute model, _) => model.toFirestore())
          .get();
      return snapshot.exists ? snapshot.data() : null;
    } on FirebaseException {
      return null;
    }
  }

  @override
  String getPath(String? uid) => '/type_route';

  @override
  User? get user => authService.service.currentUser;

  @override
  Future<ModelTypeRoute?> getModelByName({required String name}) async {
    final query = await firestore.service
        .collection(getPath(null))
        .where('name', isEqualTo: name)
        .withConverter(
            fromFirestore: ModelTypeRoute.fromFirestore,
            toFirestore: (ModelTypeRoute model, _) => model.toFirestore())
        .get();
    return query.size == 1 ? query.docs.first.data() : null;
  }

  @override
  Future<List<IModel>?> read() async {
    final collection = await firestore.service
        .collection(getPath(null))
        .withConverter(
            fromFirestore: ModelTypeRoute.fromFirestore,
            toFirestore: (ModelTypeRoute model, _) => model.toFirestore())
        .get();
    return collection.size == 0
        ? null
        : collection.docs.map((e) => e.data()).toList();
  }
}
