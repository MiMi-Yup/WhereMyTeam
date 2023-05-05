import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/repositories/route_repository.dart';
import 'package:where_my_team/domain/use_cases/team_usecases.dart';
import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/models/model_member.dart';
import 'package:where_my_team/models/model_route.dart';
import 'package:where_my_team/models/model_user.dart';
import 'package:where_my_team/presentation/map/cubit/team_map_cubit.dart';
import 'package:where_my_team/utils/alert_util.dart';
import 'package:where_my_team/utils/latlngbounds_extension.dart';

part 'map_state.dart';

@injectable
class MapCubit extends Cubit<MapState> {
  final TeamUsercase homepageUseCases;
  final TeamMapCubit userCubit;

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

  Future<void> showMembers() async {
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

  Future<void> focusToMember(int index) async {
    if (userCubit.state.teamMembers != null &&
        userCubit.state.teamMembers!.length > index) {
      ModelMember member = userCubit.state.teamMembers![index];
      ModelUser? user = await member.userEx;
      late final StreamSubscription subscription;
      if (state.focusMember == null) {
        subscription = FirebaseFirestore.instance
            .collection('/user/${user?.id}/location')
            .withConverter(
                fromFirestore: ModelLocation.fromFirestore,
                toFirestore: (ModelLocation model, _) => model.toFirestore())
            .snapshots(includeMetadataChanges: true)
            .listen((event) {
          if (event.docChanges.isNotEmpty) {
            print(event.docChanges.last.doc.data()?.id);
            emit(state.copyWith(
                cameraMap: CameraUpdate.newLatLngZoom(
                    event.docChanges.last.doc.data()!.coordinate, 17),
                status: MapStatus.focus));
          }
        });
      }
      ModelLocation? lastLocation = await user?.lastLocationEx;
      if (lastLocation != null) {
        emit(state.copyWith(
            cameraMap: CameraUpdate.newLatLngZoom(lastLocation.coordinate, 17),
            status: MapStatus.focus,
            focusMember: subscription));
      }
    }
  }

  void showRoute(/*{ModelRoute? route}*/) async {
    RouteRepository repo = getIt<RouteRepository>();
    ModelRoute? route = (await repo
        .getModelByRef(repo.getRefById('rg8hdtisklRPAJnH66aJ'))) as ModelRoute?;
    List<ModelLocation>? polyline = await route?.detailRouteEx;
    if (polyline != null && polyline.isNotEmpty) {
      List<LatLng> coordinates = polyline.map((e) => e.coordinate).toList();
      CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(
          LatLngBoundsExtension.routeLatLngBounds(coordinates), 50);
      emit(state.copyWith(polylines: {
        Polyline(
            polylineId: PolylineId(route!.id!),
            color: Colors.red,
            width: 5,
            patterns: [PatternItem.dot, PatternItem.dot],
            points: coordinates)
      }, cameraMap: cameraUpdate, status: MapStatus.bound));
    }
  }
}
