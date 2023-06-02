part of 'account_setup_cubit.dart';

enum Status { initial, submitting, success, error }

@immutable
class AccountSetupState extends Equatable {
  final String? avatar;
  final String? fullname;
  final String? phoneNumber;
  final Status state;

  bool get isFormValid =>
      avatar != null && fullname != null && phoneNumber?.length == 10;

  const AccountSetupState(
      {required this.fullname,
      required this.phoneNumber,
      required this.state,
      required this.avatar});

  factory AccountSetupState.initial() {
    return const AccountSetupState(
        fullname: null, phoneNumber: null, avatar: null, state: Status.initial);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [fullname, phoneNumber, state, avatar];

  AccountSetupState copyWith(
          {String? fullname,
          String? phoneNumber,
          Status? state,
          String? avatar}) =>
      AccountSetupState(
          fullname: fullname ?? this.fullname,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          avatar: avatar ?? this.avatar,
          state: state ?? this.state);
}
