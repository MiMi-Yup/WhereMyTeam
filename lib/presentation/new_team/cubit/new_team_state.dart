part of 'new_team_cubit.dart';

enum NewTeamEnum { init, searching, completed }

@immutable
class NewTeamState extends Equatable {
  final String? avatar;
  final String? name;
  final List<ModelUser> members;
  final List<ModelUser> friends;
  final NewTeamEnum state;

  const NewTeamState(
      {required this.avatar,
      required this.name,
      required this.members,
      required this.state,
      required this.friends});

  factory NewTeamState.initial() => const NewTeamState(
      avatar: null,
      name: null,
      members: [],
      state: NewTeamEnum.init,
      friends: []);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [avatar, name, members, state, friends];

  NewTeamState copyWith(
          {String? avatar,
          String? name,
          List<ModelUser>? members,
          List<ModelUser>? friends,
          NewTeamEnum? state}) =>
      NewTeamState(
          avatar: avatar ?? this.avatar,
          name: name ?? this.name,
          members: members ?? this.members,
          friends: friends ?? this.friends,
          state: state ?? this.state);
}
