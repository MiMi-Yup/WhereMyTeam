import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

@singleton
class GPSService {
  final Location _gpsService = Location();

  Future<bool> checkPermission() async {
    if (await isGranted) {
      final permissionGranted = await _gpsService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    _gpsService.changeSettings(interval: 10000, distanceFilter: 10);
    return true;
  }

  Future<bool> get isGranted async {
    PermissionStatus permission = await _gpsService.hasPermission();
    return permission == PermissionStatus.denied;
  }

  Stream<LocationData> get getStream => _gpsService.onLocationChanged;

  Future<LocationData> get getLocation => _gpsService.getLocation();
}
