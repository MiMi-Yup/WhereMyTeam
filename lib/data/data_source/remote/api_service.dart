import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:where_my_team/models/location_model.dart';
import 'package:configuration/utility/constants.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('${Constants.locationUrl}/last-location')
  Future<LocationModel> getLastLocation();

  @POST(Constants.locationUrl)
  Future<LocationModel> updateLocation(LocationModel location);
}