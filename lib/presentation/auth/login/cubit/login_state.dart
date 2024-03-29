part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, error }

@immutable
abstract class ALoginState extends Equatable {
  final String email;
  final String password;
  final bool rememberAccount;
  final LoginStatus status;
  final String? log;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  const ALoginState(
      {required this.email,
      required this.password,
      required this.status,
      required this.rememberAccount,
      required this.log});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props =>
      [email, password, status, rememberAccount, log];

  ALoginState copyWith(
      {String? email,
      String? password,
      LoginStatus? status,
      bool? rememberAccount,
      String? log});
}

class LoginState extends ALoginState {
  const LoginState(
      {required super.email,
      required super.password,
      required super.status,
      required super.rememberAccount,
      required super.log});

  factory LoginState.initial() {
    return const LoginState(
        email: '',
        password: '',
        status: LoginStatus.initial,
        rememberAccount: true,
        log: null);
  }

  @override
  LoginState copyWith(
      {String? email,
      String? password,
      LoginStatus? status,
      bool? rememberAccount,
      String? log}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        rememberAccount: rememberAccount ?? this.rememberAccount,
        log: log ?? this.log);
  }
}

class SignUpState extends ALoginState {
  const SignUpState(
      {required super.email,
      required super.password,
      required super.status,
      required super.rememberAccount,
      required super.log});

  factory SignUpState.initial() {
    return const SignUpState(
        email: '',
        password: '',
        status: LoginStatus.initial,
        rememberAccount: true,
        log: null);
  }

  @override
  SignUpState copyWith(
      {String? email,
      String? password,
      LoginStatus? status,
      bool? rememberAccount,
      String? log}) {
    return SignUpState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        rememberAccount: rememberAccount ?? this.rememberAccount,
        log: log ?? this.log);
  }
}
