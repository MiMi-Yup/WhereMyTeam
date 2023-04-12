import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:where_my_team/domain/repositories/unit_of_work.dart';
import 'package:where_my_team/domain/services/location_service.dart';
import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/models/model_user.dart';

@singleton
@Injectable(as: LocationService)
class LocationServiceImpl implements LocationService {
  final UnitOfWork unitOfWork;
  StreamSubscription<LocationData>? _subscription;
  LocationServiceImpl({required this.unitOfWork});

  Future<void> _eventAssign(LocationData event) async {
    ModelUser? user = await unitOfWork.user.getCurrentUser();
    if (user != null) {
      ModelLocation location = ModelLocation(
          id: event.time?.toInt().toString(),
          user: unitOfWork.user.getRef(user),
          route: null,
          timestamp: event.time == null
              ? Timestamp.now()
              : Timestamp.fromMillisecondsSinceEpoch(event.time!.toInt()),
          altitude: event.altitude,
          latitude: event.latitude,
          longitude: event.longitude,
          satelliteNumber: event.satelliteNumber,
          speed: event.speed);
      unitOfWork.location.insert(location);
      unitOfWork.user.putLastLocation(lastLocation: location);
    }
  }

  @override
  Future<void> updateLocation() async {
    if (_subscription == null &&
        await unitOfWork.gps.checkPermission() == true) {
      Stream<LocationData>? stream = await unitOfWork.gps.getStream();
      if (stream != null) {
        _subscription = stream.listen(_eventAssign);
      }
    }
  }
}
