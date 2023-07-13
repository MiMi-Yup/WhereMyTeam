import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wmteam/models/model.dart';

class ModelTypeRoute extends IModel {
  String? name;
  String? image;

  ModelTypeRoute(
      {required super.id,
      this.name,
      this.image});

  ModelTypeRoute.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options)
      : super.fromFirestore(snapshot, options) {
    Map<String, dynamic>? data = snapshot.data();
    name = data?['name'];
    image = data?['image'];
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'image': image
    };
  }

  @override
  Map<String, dynamic> updateFirestore() => {};
}