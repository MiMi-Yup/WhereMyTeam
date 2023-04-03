import 'dart:async';
import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/data/data_source/remote/api_service.dart';
import 'package:where_my_team/domain/repositories/location_repository.dart';
import 'package:where_my_team/models/location_model.dart';
import 'package:where_my_team/models/request/get_user_request.dart';
import 'package:where_my_team/models/response/get_user_response.dart';

@Injectable(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  ApiService? api;
  LocationRepositoryImpl({this.api});

  // @override
  // FutureOr<GetLocationResponse?> getLocation(
  //     GetLocationRequest? request) async {
  //   // if (request == null || request.test == null) {
  //   //   throw NullThrownError();
  //   // }
  //   LocationModel? result = await api?.getLastLocation();
  //   return GetLocationResponse.fromJson({
  //     'data': LocationModel.fromJson({'test': "test"}).toJson()
  //   });
  // }
  
  // @override
  // FutureOr<GetLocationResponse?> updateLocation(GetLocationRequest? request) {
  //   // TODO: implement updateLocation
  //   throw UnimplementedError();
  // }
}
