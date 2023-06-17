import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IModel {
  String? id;
  IModel({required this.id});

  IModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    id = snapshot.id;
  }
  
  Map<String, dynamic> toFirestore();
  Map<String, dynamic> updateFirestore();
}
