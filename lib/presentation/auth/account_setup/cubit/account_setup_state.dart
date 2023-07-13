part of 'account_setup_cubit.dart';

enum Status { initial, submitting, success, error }

@immutable
class AccountSetupState extends Equatable {
  final String? avatar;
  final String initAvatar;
  final String? fullname;
  final String? phoneNumber;
  final Status state;
  final bool signUp;

  bool get isFormValid => fullname != null && phoneNumber?.length == 10;

  const AccountSetupState(
      {required this.fullname,
      required this.phoneNumber,
      required this.state,
      this.initAvatar =
          'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png',
      required this.avatar,
      this.signUp = false});

  factory AccountSetupState.initial(
      {bool signUp = false, bool isFireStorageImage = true}) {
    return AccountSetupState(
        fullname: null,
        phoneNumber: null,
        avatar: null,
        signUp: signUp,
        state: Status.initial);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props =>
      [fullname, phoneNumber, state, avatar, signUp, initAvatar];

  AccountSetupState copyWith(
          {String? fullname,
          String? phoneNumber,
          Status? state,
          String? avatar,
          String? initAvatar}) =>
      AccountSetupState(
          fullname: fullname ?? this.fullname,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          avatar: avatar ?? this.avatar,
          state: state ?? this.state,
          initAvatar: initAvatar ?? this.initAvatar);
}
