part of 'friend_list_cubit.dart';

enum Status { init, searching, completed }

@immutable
class FriendListState extends Equatable {
  final List<ModelUser> members;

  const FriendListState({required this.members});

  factory FriendListState.initial() => const FriendListState(members: []);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [members];

  FriendListState copyWith({List<ModelUser>? members}) =>
      FriendListState(members: members ?? this.members);
}
