part of 'route_cubit.dart';

class RouteState extends Equatable {
  final SplayTreeMap<String, List<ModelRoute>?> routes;
  const RouteState({required this.routes});

  factory RouteState.initial() => RouteState(routes: SplayTreeMap.from({}));

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [routes];

  RouteState copyWith({SplayTreeMap<String, List<ModelRoute>?>? routes}) =>
      RouteState(routes: routes ?? this.routes);
}
