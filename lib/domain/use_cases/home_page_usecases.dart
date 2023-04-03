import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:where_my_team/domain/repositories/unit_of_work.dart';

// @injectable
// class HomepageUseCases {
//   final LocationRepository locationRepo;

//   HomepageUseCases({required this.locationRepo});

//   FutureOr<LocationModel?> getSetting(String? param) async {
//     if(param == null) {
//       throw NullThrownError();
//     }
//     final response = await locationRepo.getLocation(GetLocationRequest(param));
//     return response?.data;
//   }
// }

@injectable
class HomepageUseCases {
  final UnitOfWork unitOfWork;

  HomepageUseCases({required this.unitOfWork});

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

  Future getLocation() async {
    // unitOfWork.Location.getLocation(null);
  }
}
