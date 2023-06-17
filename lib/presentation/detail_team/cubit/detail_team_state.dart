part of 'detail_team_cubit.dart';

@immutable
class DetailTeamState extends Equatable {
  final bool isAdminOfTeam;
  final ModelTeam? team;
  const DetailTeamState({required this.isAdminOfTeam, required this.team});

  factory DetailTeamState.initial() =>
      const DetailTeamState(isAdminOfTeam: false, team: null);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [isAdminOfTeam, team];

  DetailTeamState copyWith({bool? isAdminOfTeam, ModelTeam? team}) =>
      DetailTeamState(
          isAdminOfTeam: isAdminOfTeam ?? this.isAdminOfTeam,
          team: team ?? this.team);
}
