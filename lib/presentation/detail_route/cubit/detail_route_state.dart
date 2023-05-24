part of 'detail_route_cubit.dart';

@immutable
class DetailRouteState extends Equatable {
  final Set<Polyline> polylines;
  final CameraUpdate? cameraUpdate;
  final ModelRoute? route;
  final List<ModelLocation> timeline;
  const DetailRouteState(
      {required this.polylines,
      required this.cameraUpdate,
      required this.route,
      required this.timeline});

  factory DetailRouteState.initial() => const DetailRouteState(
      polylines: {}, cameraUpdate: null, route: null, timeline: []);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [polylines, cameraUpdate, route, timeline];

  DetailRouteState copyWith(
          {Set<Polyline>? polylines,
          CameraUpdate? cameraUpdate,
          ModelRoute? route,
          List<ModelLocation>? timeline}) =>
      DetailRouteState(
          polylines: polylines ?? this.polylines,
          cameraUpdate: cameraUpdate ?? this.cameraUpdate,
          route: route ?? this.route,
          timeline: timeline ?? this.timeline);
}
