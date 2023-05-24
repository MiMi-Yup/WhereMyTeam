part of 'team_cubit.dart';

@immutable
class TeamState extends Equatable {
  final Map<String, StreamSubscription> streamSubscription;
  final ModelTeam? familyTeam;
  const TeamState({required this.streamSubscription, required this.familyTeam});

  factory TeamState.initial() =>
      const TeamState(streamSubscription: {}, familyTeam: null);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [streamSubscription, familyTeam];

  TeamState copyWith(
          {Map<String, StreamSubscription>? streamSubscription,
          ModelTeam? familyTeam}) =>
      TeamState(
          streamSubscription: streamSubscription ?? this.streamSubscription,
          familyTeam: familyTeam ?? this.familyTeam);
}
