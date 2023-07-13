part of 'add_friend_cubit.dart';

enum AddFriendEnum { init, searching, completed }

@immutable
class AddFriendState extends Equatable {
  final String? avatar;
  final String? name;
  final String? search;
  final List<ModelUser> members;
  final AddFriendEnum state;

  const AddFriendState(
      {required this.avatar,
      required this.name,
      this.search = '',
      required this.members,
      required this.state});

  factory AddFriendState.initial() => const AddFriendState(
      avatar: null, name: null, members: [], state: AddFriendEnum.init);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [avatar, name, search, members, state];

  AddFriendState copyWith(
          {String? avatar,
          String? name,
          String? search,
          List<ModelUser>? members,
          AddFriendEnum? state}) =>
      AddFriendState(
          avatar: avatar ?? this.avatar,
          name: name ?? this.name,
          search: search ?? this.search,
          members: members ?? this.members,
          state: state ?? this.state);
}
