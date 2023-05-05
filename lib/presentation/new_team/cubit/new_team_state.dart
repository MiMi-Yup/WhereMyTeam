part of 'new_team_cubit.dart';

enum NewTeamEnum { init, searching, completed }

@immutable
class NewTeamState extends Equatable {
  final String? avatar;
  final String? name;
  final String? search;
  final List<ModelUser> members;
  final NewTeamEnum state;

  const NewTeamState(
      {required this.avatar,
      required this.name,
      this.search = '',
      required this.members,
      required this.state});

  factory NewTeamState.initial() => const NewTeamState(
      avatar: null, name: null, members: [], state: NewTeamEnum.init);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [avatar, name, search, members];

  NewTeamState copyWith(
          {String? avatar,
          String? name,
          String? search,
          List<ModelUser>? members,
          NewTeamEnum? state}) =>
      NewTeamState(
          avatar: avatar ?? this.avatar,
          name: name ?? this.name,
          search: search ?? this.search,
          members: members ?? this.members,
          state: state ?? this.state);
}
