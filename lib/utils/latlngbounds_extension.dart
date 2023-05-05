import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class LatLngBoundsExtension {
  LatLngBounds? calculateLatLngBounds(List<Marker> markers) {
    if (markers.isEmpty) {
      return null;
    }

    // Calculate the center of all markers
    LatLng center = LatLng(
      markers
              .map((marker) => marker.position.latitude)
              .reduce((a, b) => a + b) /
          markers.length,
      markers
              .map((marker) => marker.position.longitude)
              .reduce((a, b) => a + b) /
          markers.length,
    );

    // Calculate the distances of all markers from the center
    List<double> distances =
        markers.map((marker) => distance(center, marker.position)).toList();

    // Calculate the median distance
    distances.sort();
    double medianDistance = distances[distances.length ~/ 2];

    // Filter out any markers that are too far from the median distance
    markers.firstWhere(
        (element) => distance(center, element.position) >= medianDistance);
  }

  static LatLngBounds routeLatLngBounds(List<LatLng> coordinates) {
    double minLat = coordinates.first.latitude;
    double minLng = coordinates.first.longitude;
    double maxLat = coordinates.first.latitude;
    double maxLng = coordinates.first.longitude;

    for (final latLng in coordinates) {
      if (latLng.latitude < minLat) {
        minLat = latLng.latitude;
      }
      if (latLng.longitude < minLng) {
        minLng = latLng.longitude;
      }
      if (latLng.latitude > maxLat) {
        maxLat = latLng.latitude;
      }
      if (latLng.longitude > maxLng) {
        maxLng = latLng.longitude;
      }
    }

    final southWest = LatLng(minLat, minLng);
    final northEast = LatLng(maxLat, maxLng);

    return LatLngBounds(southwest: southWest, northeast: northEast);
  }

  static double distance(LatLng a, LatLng b) {
    const earthRadius = 6378137.0;
    double lat1 = _radians(a.latitude);
    double lng1 = _radians(a.longitude);
    double lat2 = _radians(b.latitude);
    double lng2 = _radians(b.longitude);
    double dLat = lat2 - lat1;
    double dLng = lng2 - lng1;
    double x = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLng / 2) * sin(dLng / 2);
    double c = 2 * atan2(sqrt(x), sqrt(1 - x));
    return earthRadius * c;
  }

  static double _radians(double degrees) {
    return degrees * pi / 180;
  }
}
