part of 'friend_request_cubit.dart';

@immutable
class FriendRequestState extends Equatable {
  final List<ModelUser> members;

  const FriendRequestState({required this.members});

  factory FriendRequestState.initial() => const FriendRequestState(members: []);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [members];

  FriendRequestState copyWith({List<ModelUser>? members}) =>
      FriendRequestState(members: members ?? this.members);
}
