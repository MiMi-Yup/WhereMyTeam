import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:wmteam/domain/repositories/unit_of_work.dart';
import 'package:wmteam/models/model_user.dart';

@injectable
class MapUseCases {
  final UnitOfWork unitOfWork;

  MapUseCases({required this.unitOfWork});

  FutureOr<LocationData?> getCurrentLocation() async {
    LocationData? data = await unitOfWork.gps.getCurrentLocation();
    return data;
  }

  Future<Stream<LocationData>?> getStreamLocation() async {
    Stream<LocationData>? data = await unitOfWork.gps.getStream();
    return data;
  }

  Future<bool> checkAndAskPermission() async {
    bool? allow = await unitOfWork.gps.checkPermission();
    return allow ?? false;
  }

  Stream<DocumentSnapshot<ModelUser>>? snapshot(ModelUser? user) =>
      user?.id == null ? null : unitOfWork.user.snapshot(userId: user!.id!);
}
