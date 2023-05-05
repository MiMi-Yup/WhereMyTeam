part of 'map_cubit.dart';

enum MapStatus { initial, bound, focus }

@immutable
class MapState extends Equatable {
  final Set<Marker> members;
  final Set<Polyline> polylines;
  final CameraUpdate? cameraMap;
  final MapStatus status;
  final StreamSubscription? focusMember;

  const MapState(
      {required this.members,
      required this.polylines,
      required this.cameraMap,
      required this.status,
      required this.focusMember});

  factory MapState.initial() => const MapState(
      members: <Marker>{},
      cameraMap: null,
      focusMember: null,
      status: MapStatus.initial,
      polylines: <Polyline>{});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props =>
      [members, polylines, cameraMap, status, focusMember];

  MapState copyWith(
          {Set<Marker>? members,
          CameraUpdate? cameraMap,
          Set<Polyline>? polylines,
          MapStatus? status,
          StreamSubscription? focusMember,
          bool overrideFocusMember = true}) =>
      MapState(
          members: members ?? this.members,
          polylines: polylines ?? this.polylines,
          cameraMap: cameraMap ?? this.cameraMap,
          status: status ?? this.status,
          focusMember: overrideFocusMember
              ? focusMember
              : (focusMember ?? this.focusMember));
}
