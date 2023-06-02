import 'package:google_maps_flutter/google_maps_flutter.dart';

class LatLngBoundsExtension {
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
}
