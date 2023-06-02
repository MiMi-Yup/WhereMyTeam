import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:where_my_team/domain/use_cases/map_usecases.dart';
import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/models/model_member.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/models/model_user.dart';
import 'package:where_my_team/presentation/map/cubit/team_map_cubit.dart';
import 'package:where_my_team/utils/alert_util.dart';
import 'package:where_my_team/utils/latlngbounds_extension.dart';

part 'map_state.dart';

@injectable
class MapCubit extends Cubit<MapState> {
  final MapUsercase mapUseCases;
  final TeamMapCubit userCubit;
  LocationData? _currentLocation;
  StreamSubscription? subscriptionStreamLocation;
  final List<StreamSubscription> _markersSubcription = [];
  StreamSubscription? _focusSubcription = null;

  MapCubit({required this.mapUseCases, required this.userCubit})
      : super(MapState.initial()) {
    getStream();
  }

  FutureOr<Stream<LocationData>?> getStream() async {
    final stream = await mapUseCases.getStreamLocation();
    if (subscriptionStreamLocation == null && stream != null) {
      subscriptionStreamLocation =
          stream.listen((event) => _currentLocation = event);
    }
    return stream;
  }

  LocationData? get currentLocation => _currentLocation;

  void goToMyLocation() async {
    if (_currentLocation != null) {
      _disposeFocus();
      emit(state.copyWith(
          cameraMap: CameraUpdate.newLatLngZoom(
              LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
              17),
          status: MapStatus.focus));
    }
  }

  FutureOr<bool> checkPermission() {
    return mapUseCases.checkAndAskPermission();
  }

  void _disposeFocus() {
    _focusSubcription?.cancel();
    _focusSubcription = null;
    emit(state.copyWith(status: MapStatus.initial));
  }

  void focusToMember(ModelMember? member) async {
    final ModelUser? user = await member?.userEx;
    focusToUser(user);
  }

  void focusToUser(ModelUser? user) async {
    _disposeFocus();
    if (user != null) {
      _focusSubcription = mapUseCases.snapshot(user)?.listen((event) async {
        final user = event.data();
        if (!event.exists || user == null) return;
        final lastLocation = await user.lastLocationEx;
        if (lastLocation == null ||
            lastLocation.latitude == null ||
            lastLocation.longitude == null) return;
        emit(state.copyWith(
            cameraMap: CameraUpdate.newLatLngZoom(lastLocation.coordinate, 19),
            status: MapStatus.focus));
      });
    }
  }

  // void showRoute(/*{ModelRoute? route}*/) async {
  //   RouteRepository repo = getIt<RouteRepository>();
  //   ModelRoute? route = (await repo
  //       .getModelByRef(repo.getRefById('rg8hdtisklRPAJnH66aJ'))) as ModelRoute?;
  //   List<ModelLocation>? polyline = await route?.detailRouteEx;
  //   if (polyline != null && polyline.isNotEmpty) {
  //     List<LatLng> coordinates = polyline.map((e) => e.coordinate).toList();
  //     CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(
  //         LatLngBoundsExtension.routeLatLngBounds(coordinates), 50);
  //     emit(state.copyWith(polylines: {
  //       Polyline(
  //           polylineId: PolylineId(route!.id!),
  //           color: Colors.red,
  //           width: 5,
  //           patterns: [PatternItem.dot, PatternItem.dot],
  //           points: coordinates)
  //     }, cameraMap: cameraUpdate, status: MapStatus.bound));
  //   }
  // }

  void _handleStream(List<Stream<DocumentSnapshot<ModelUser>>> streamList) {
    for (var stream in streamList) {
      _markersSubcription
          .add(stream.listen((snapshot) => _handleDocumentSnapshot(snapshot)));
    }
  }

  void _disposeMarkers() {
    for (var element in _markersSubcription) {
      element.cancel();
    }
    _markersSubcription.clear();
    emit(state.copyWith(members: {}, status: MapStatus.initial));
  }

  void _handleDocumentSnapshot(DocumentSnapshot<ModelUser> snapshot) async {
    final user = snapshot.data();
    if (!snapshot.exists || user == null) return;
    final userId = snapshot.id;
    final lastLocation = await user.lastLocationEx;
    if (lastLocation == null ||
        lastLocation.latitude == null ||
        lastLocation.longitude == null) return;
    final updatedMarkers = {...state.members};
    updatedMarkers.removeWhere((marker) => marker.markerId.value == userId);
    updatedMarkers.add(
      Marker(
          icon: await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(48, 48)),
              'assets/img/google.png'),
          flat: true,
          onTap: () => AlertUtil.showLoading(),
          infoWindow: InfoWindow(title: user.name),
          markerId: MarkerId(user.id!),
          position: lastLocation.coordinate),
    );

    try {
      emit(state.copyWith(members: updatedMarkers));
    } catch (ex) {}
  }

  void changeTeam(ModelTeam team) async {
    _disposeMarkers();
    _disposeFocus();
    final member = await team.membersEx;
    if (member != null && member.isNotEmpty) {
      final users = await Future.wait(member.map((e) => e.userEx));
      final lastLocations = await Future.wait(users
          .where((element) => element != null)
          .map((e) => e!.lastLocationEx));
      final listCoordinate = lastLocations
          .where((element) => element != null)
          .map((e) => e!.coordinate)
          .toList();
      if (listCoordinate.isNotEmpty) {
        CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(
            LatLngBoundsExtension.routeLatLngBounds(listCoordinate), 50);
        emit(state.copyWith(cameraMap: cameraUpdate, status: MapStatus.bound));
      }
      final snapshots = users
          .map((e) => mapUseCases.snapshot(e))
          .where((element) => element != null)
          .cast<Stream<DocumentSnapshot<ModelUser>>>()
          .toList();
      _handleStream(snapshots);
    }
  }
}
