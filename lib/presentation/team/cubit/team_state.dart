part of 'team_cubit.dart';

@immutable
class TeamState extends Equatable {
  const TeamState();

  factory TeamState.initial() =>
      const TeamState();

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];

  TeamState copyWith() =>
      TeamState();
}