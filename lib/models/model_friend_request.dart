import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/domain/repositories/route_repository.dart';
import 'package:wmteam/domain/repositories/user_repository.dart';
import 'package:wmteam/models/model_route.dart';
import 'package:wmteam/models/model_user.dart';
import 'model.dart';

class ModelFriendRequest extends IModel {
  DocumentReference? sender;
  DocumentReference? receiver;
  bool? status;

  ModelFriendRequest(
      {required super.id,
      required this.sender,
      required this.receiver,
      required this.status});

  ModelFriendRequest.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options)
      : super.fromFirestore(snapshot, options) {
    Map<String, dynamic>? data = snapshot.data();
    sender = data?['sender'];
    receiver = data?['receiver'];
    status = data?['status'];
  }

  @override
  Map<String, dynamic> toFirestore() =>
      {'sender': sender, 'receiver': receiver, 'status': status};

  @override
  Map<String, dynamic> updateFirestore() => {'status': status};
}

extension ExtensionModelFriendRequest on ModelFriendRequest {
  Future<ModelUser?> get senderEx async => sender == null
      ? null
      : await getIt<UserRepository>().getModelByRef(sender!) as ModelUser;

  Future<ModelUser?> get receiverEx async => receiver == null
      ? null
      : await getIt<UserRepository>().getModelByRef(receiver!) as ModelUser;
}
