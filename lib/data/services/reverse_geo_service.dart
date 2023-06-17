import 'package:geocoding/geocoding.dart';

class ReverseGeoService {
  Future<List<Placemark>> getAddress(
      {required double latitude, required double longitude}) {
    return placemarkFromCoordinates(latitude, longitude)
        .then((value) => value)
        .onError((error, stackTrace) => []);
  }
}
