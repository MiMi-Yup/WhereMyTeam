import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:where_my_team/models/model.dart';

abstract class GenericRepository {
  FirebaseFirestore get firestoreService;
  User? get user;

  Future<void> insert(IModel model) {
    return firestoreService
        .collection(getPath(user?.uid))
        .doc(model.id)
        .set(model.toFirestore(), SetOptions(merge: true));
  }

  Future<void> update(IModel was, IModel update) {
    return firestoreService
        .collection(getPath(user?.uid))
        .doc(was.id)
        .update(update.updateFirestore());
  }

  DocumentReference<Map<String, dynamic>> getRef(IModel model) {
    return firestoreService.collection(getPath(user?.uid)).doc(model.id);
  }

  DocumentReference<Map<String, dynamic>> getRefById(String id) {
    return firestoreService.collection(getPath(user?.uid)).doc(id);
  }

  CollectionReference<Map<String, dynamic>> getCollectionRef() =>
      firestoreService.collection(getPath(user?.uid));

  Future<void> delete(IModel model);
  String getPath(String? uid);
  Future<List<IModel>?> read();
  Future<IModel?> getModelByRef(DocumentReference<Object?> ref);
}
