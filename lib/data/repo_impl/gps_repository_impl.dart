import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:wmteam/data/data_source/local/gps_service.dart';
import 'package:wmteam/domain/repositories/gps_repository.dart';

@Injectable(as: GPSRepository)
class GPSRepositoryImpl implements GPSRepository {
  final GPSService? gps;
  bool _allowPermission = false;
  GPSRepositoryImpl({required this.gps});

  @override
  FutureOr<bool?> checkPermission() async {
    bool? permission = await gps?.checkPermission();
    _allowPermission = permission ?? false;
    return permission;
  }

  @override
  FutureOr<LocationData?> getCurrentLocation() async {
    if (_allowPermission || await checkPermission() == true) {
      return gps?.getLocation;
    }
    return null;
  }

  @override
  FutureOr<Stream<LocationData>?> getStream() async {
    if (_allowPermission || await checkPermission() == true) {
      return gps?.getStream;
    }
    return null;
  }
}
