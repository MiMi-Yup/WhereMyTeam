part of 'account_setup_cubit.dart';

@immutable
class AccountSetupState extends Equatable {
  final String? avatar;
  final String? name;
  final String? phoneNumber;

  const AccountSetupState(
      {required this.avatar, required this.name, required this.phoneNumber});

  factory AccountSetupState.initial() =>
      const AccountSetupState(avatar: null, name: null, phoneNumber: null);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [avatar, name, phoneNumber];

  AccountSetupState copyWith(
          {String? avatar, String? name, String? phoneNumber}) =>
      AccountSetupState(
          avatar: avatar ?? this.avatar,
          name: name ?? this.name,
          phoneNumber: phoneNumber ?? this.phoneNumber);
}
