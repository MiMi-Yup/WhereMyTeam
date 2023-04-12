part of 'home_cubit.dart';

@immutable
class HomeState extends Equatable {
  final ModelUser? user;
  final ModelTeam? currentTeam;
  final List<ModelMember>? teamMembers;

  const HomeState(
      {required this.user,
      required this.currentTeam,
      required this.teamMembers});

  factory HomeState.initial() =>
      const HomeState(user: null, currentTeam: null, teamMembers: null);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [user, currentTeam, teamMembers];

  HomeState copyWith(
          {ModelUser? user,
          ModelTeam? currentTeam,
          List<ModelMember>? teamMembers}) =>
      HomeState(
          user: user ?? this.user,
          currentTeam: currentTeam ?? this.currentTeam,
          teamMembers: teamMembers ?? this.teamMembers);
}
