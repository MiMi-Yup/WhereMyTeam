part of 'team_map_cubit.dart';

@immutable
class TeamMapState extends Equatable {
  final ModelUser? user;
  final ModelTeam? currentTeam;
  final List<ModelMember>? teamMembers;

  const TeamMapState(
      {required this.user,
      required this.currentTeam,
      required this.teamMembers});

  factory TeamMapState.initial() =>
      const TeamMapState(user: null, currentTeam: null, teamMembers: null);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [user, currentTeam, teamMembers];

  TeamMapState copyWith(
          {ModelUser? user,
          ModelTeam? currentTeam,
          List<ModelMember>? teamMembers}) =>
      TeamMapState(
          user: user ?? this.user,
          currentTeam: currentTeam ?? this.currentTeam,
          teamMembers: teamMembers ?? this.teamMembers);
}
