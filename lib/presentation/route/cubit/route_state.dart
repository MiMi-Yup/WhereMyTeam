part of 'route_cubit.dart';

@immutable
class RouteState extends Equatable {
  const RouteState();

  factory RouteState.initial() =>
      const RouteState();

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];

  RouteState copyWith() =>
      RouteState();
}