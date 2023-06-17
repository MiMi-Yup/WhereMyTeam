import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/data/data_source/remote/firestore_service.dart';
import 'package:where_my_team/domain/repositories/role_repository.dart';
import 'package:where_my_team/models/model_role.dart';
import 'package:where_my_team/models/model.dart';

@Injectable(as: RoleRepository)
class RoleRepositoryImpl extends RoleRepository {
  final FirestoreService firestore;

  RoleRepositoryImpl({required this.firestore});

  @override
  Future<bool> allowExecute(
      {required ModelRole source, required ModelRole target}) async {
    return (source.weightNo ?? 10) <= (target.weightNo ?? 10);
  }

  @override
  Future<void> delete(IModel model) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  FirebaseFirestore get firestoreService => firestore.service;

  @override
  Future<ModelRole?> getModelByRef(DocumentReference<Object?> ref) async {
    DocumentSnapshot<ModelRole> snapshot = await ref
        .withConverter(
            fromFirestore: ModelRole.fromFirestore,
            toFirestore: (ModelRole model, _) => model.toFirestore())
        .get();
    return snapshot.exists ? snapshot.data() : null;
  }

  @override
  String getPath(String? uid) => '/role';

  @override
  Future<ModelRole?> getRole({required String id}) {
    return getModelByRef(getRefById(id));
  }

  @override
  Future<List<ModelRole>?> read() async {
    QuerySnapshot<ModelRole> snapshot = await firestore.service
        .collection(getPath(null))
        .withConverter(
            fromFirestore: ModelRole.fromFirestore,
            toFirestore: (ModelRole model, _) => model.toFirestore())
        .get();
    return snapshot.size > 0
        ? snapshot.docs.map((e) => e.data()).toList()
        : null;
  }

  @override
  User? get user => null;
}
