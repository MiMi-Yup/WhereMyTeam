import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential?> signUpByPassword(
      {required String email, required String password});
  Future<UserCredential?> loginByPassword(
      {required String email, required String password});
  Future<UserCredential?> loginByGoogle();
  Future<UserCredential?> loginByCredentail(
      {required AuthCredential credential});
  Future<bool> signOut();
}
