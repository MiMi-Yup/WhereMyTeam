import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/domain/use_cases/login_page_usecases.dart';
import 'package:wmteam/models/model_user.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<ALoginState> {
  final LoginUseCases loginUserCases;

  LoginCubit({required this.loginUserCases}) : super(LoginState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  void rememberAccount(bool remember) {
    emit(
        state.copyWith(rememberAccount: remember, status: LoginStatus.initial));
  }

  void swapAccess() {
    emit(state is LoginState ? SignUpState.initial() : LoginState.initial());
  }

  void primaryAction() async {
    if (state.isFormValid) {
      emit(state.copyWith(status: LoginStatus.submitting));
      late ModelUser? user;
      if (state is SignUpState) {
        user = await loginUserCases.signUpPassword(
            '', state.email, state.password);
      } else {
        user = await loginUserCases.loginPassword(state.email, state.password,
            remember: state.rememberAccount);
      }
      if (user == null) emit(state.copyWith(status: LoginStatus.error));
    } else {
      emit(state.copyWith(status: LoginStatus.error));
    }
  }

  void loginByGoogle() {
    loginUserCases.loginGoogle(remember: state.rememberAccount);
  }
}
