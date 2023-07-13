import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/domain/use_cases/route_usecases.dart';
import 'package:wmteam/models/model_location.dart';
import 'package:wmteam/models/model_route.dart';
import 'package:wmteam/utils/latlngbounds_extension.dart';

part 'detail_route_state.dart';

@injectable
class DetailRouteCubit extends Cubit<DetailRouteState> {
  final RouteUseCases usecase;
  final ModelRoute route;
  DetailRouteCubit({required this.usecase, required this.route})
      : super(DetailRouteState.initial());

  Future<bool> loadRoute() async {
    final locations = await route.detailRouteEx;
    if (locations == null || locations.isEmpty) return false;
    final coordinates = locations.map((e) => e.coordinate).toList();
    for (var element in coordinates) {
      debugPrint('${element.latitude},${element.longitude}');
    }
    emit(state.copyWith(
        route: route,
        timeline: locations,
        cameraUpdate: CameraUpdate.newLatLngBounds(
            LatLngBoundsExtension.routeLatLngBounds(coordinates), 50),
        polylines: {
          Polyline(
              polylineId: PolylineId(route.id!),
              color: Colors.red,
              width: 5,
              points: coordinates)
        }));
    return true;
  }
}
