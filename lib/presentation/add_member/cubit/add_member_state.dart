part of 'add_member_cubit.dart';

enum Status { init, searching, completed }

@immutable
class AddMemberState extends Equatable {
  final String? search;
  final List<ModelUser> members;
  final Status state;

  const AddMemberState(
      {this.search = '', required this.members, required this.state});

  factory AddMemberState.initial() =>
      const AddMemberState(members: [], state: Status.init);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [search, members, state];

  AddMemberState copyWith(
          {String? search, List<ModelUser>? members, Status? state}) =>
      AddMemberState(
          search: search ?? this.search,
          members: members ?? this.members,
          state: state ?? this.state);
}
