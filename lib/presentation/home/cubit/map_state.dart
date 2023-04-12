part of 'map_cubit.dart';

@immutable
class MapState extends Equatable {
  final ModelLocation? focusLocation;
  final CameraPosition locationCamera;
  final Set<Marker> members;
  final Set<Polyline> polylines;

  const MapState(
      {required this.members,
      required this.locationCamera,
      required this.focusLocation,
      required this.polylines});

  factory MapState.initial() => const MapState(
      members: <Marker>{},
      focusLocation: null,
      locationCamera: CameraPosition(
        target: LatLng(10.762622, 106.660172),
        zoom: 20,
      ),
      polylines: <Polyline>{});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props =>
      [members, focusLocation, polylines, locationCamera];

  MapState copyWith(
          {Set<Marker>? members,
          ModelLocation? focusLocation,
          CameraPosition? locationCamera,
          Set<Polyline>? polylines}) =>
      MapState(
          members: members ?? this.members,
          locationCamera: locationCamera ?? this.locationCamera,
          focusLocation: focusLocation ?? this.focusLocation,
          polylines: polylines ?? this.polylines);
}
