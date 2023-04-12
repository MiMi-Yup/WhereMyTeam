import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:where_my_team/domain/use_cases/home_page_usecases.dart';
import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/models/model_member.dart';
import 'package:where_my_team/models/model_route.dart';
import 'package:where_my_team/models/model_team_user.dart';
import 'package:where_my_team/models/model_user.dart';
import 'package:where_my_team/presentation/home/cubit/home_cubit.dart';
import 'package:where_my_team/utils/alert_util.dart';

part 'map_state.dart';

@injectable
class MapCubit extends Cubit<MapState> {
  final HomepageUseCases homepageUseCases;
  final HomeCubit userCubit;

  MapCubit({required this.homepageUseCases, required this.userCubit})
      : super(MapState.initial());

  FutureOr<Stream<LocationData>?> getStream() {
    return homepageUseCases.getStreamLocation();
  }

  Future<LocationData?> getCurrentLocation() async {
    return await homepageUseCases.getCurrentLocation();
  }

  FutureOr<bool> checkPermission() {
    return homepageUseCases.checkAndAskPermission();
  }

  void showMembers() async {
    if (userCubit.state.teamMembers != null) {
      List<Marker?> markers = await Future.wait<Marker?>(
          userCubit.state.teamMembers!.map((e) async {
        ModelUser? user = await e.userEx;
        ModelLocation? location = await user?.lastLocationEx;
        return user == null || location == null
            ? null
            : Marker(
                icon: await BitmapDescriptor.fromAssetImage(
                    const ImageConfiguration(size: Size(48, 48)),
                    'assets/img/google.png'),
                flat: true,
                onTap: () => AlertUtil.showLoading(),
                infoWindow: InfoWindow(title: user.name),
                markerId: MarkerId(user.id!),
                position: LatLng(location.latitude!, location.longitude!));
      }));
      emit(state.copyWith(
          members: markers
              .where((element) => element != null)
              .cast<Marker>()
              .toSet()));
    }
  }

  void addRoute() {}

  void removeRoute() {}

  void clearMember() {}

  void addMember() {}

  void focusToMember() {}

  void showLocationPerson(ModelUser? user) async {
    ModelLocation? location = await user?.lastLocationEx;
    if (location != null) emit(state.copyWith(focusLocation: location));
  }

  void showRoute(ModelRoute? route) async {
    List<ModelLocation>? polyline = await route?.detailRouteEx;
    if (polyline != null && polyline.isNotEmpty) {
      emit(state.copyWith(polylines: {
        Polyline(
            polylineId: PolylineId(route!.id!),
            color: Colors.red,
            width: 5,
            patterns: [PatternItem.dot, PatternItem.dot],
            points:
                polyline.map((e) => LatLng(e.latitude!, e.longitude!)).toList())
      }));
    }
  }
}
