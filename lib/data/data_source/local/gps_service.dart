import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

@singleton
class GPSService {
  final Location _gpsService = Location();

  Future<bool> checkPermission() async {
    PermissionStatus _permissionGranted = await _gpsService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _gpsService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    _gpsService.changeSettings(interval: 10000, distanceFilter: 10);
    return true;
  }

  Stream<LocationData> get getStream => _gpsService.onLocationChanged;

  Future<LocationData> get getLocation => _gpsService.getLocation();
}