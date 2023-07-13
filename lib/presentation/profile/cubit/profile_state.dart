part of 'profile_cubit.dart';

@immutable
class ProfileState extends Equatable {
  const ProfileState();

  factory ProfileState.initial() => const ProfileState();

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];

  ProfileState copyWith() => const ProfileState();
}
