import 'dart:math';
import 'package:location/location.dart';
import 'package:wmteam/models/model_location.dart';

double _calculate(double? sLat, double? sLon, double? eLat, double? eLon) {
  if (sLat == null || sLon == null || eLat == null || eLon == null) return 0.0;
  var earthRadius = 6378137.0;
  var dLat = _degreesToRadians(eLat - sLat);
  var dLon = _degreesToRadians(eLon - sLon);

  var a = pow(sin(dLat / 2), 2) +
      pow(sin(dLon / 2), 2) *
          cos(_degreesToRadians(sLat)) *
          cos(_degreesToRadians(eLat));
  var c = 2 * asin(sqrt(a));

  return earthRadius * c;
}

double _calculateDistance(LocationData start, LocationData end) =>
    _calculate(start.latitude, start.longitude, end.latitude, end.longitude);

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

extension LatLngExtension on LocationData {
  double distance(LocationData coordinate) =>
      _calculateDistance(this, coordinate);
}

extension ModelLocationExtension on ModelLocation {
  double distance(ModelLocation coordinate) => _calculate(
      latitude, longitude, coordinate.latitude, coordinate.longitude);
}
