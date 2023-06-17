import 'package:cloud_firestore/cloud_firestore.dart';
import 'model.dart';

class ModelRole extends IModel {
  String? name;
  int? weightNo;

  ModelRole({required super.id, required this.name, required this.weightNo});

  ModelRole.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options)
      : super.fromFirestore(snapshot, options) {
    Map<String, dynamic>? data = snapshot.data();
    name = data?['name'];
    weightNo = data?['weightNo'];
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {'name': name, 'weightNo': weightNo};
  }

  @override
  Map<String, dynamic> updateFirestore() => toFirestore();
}
