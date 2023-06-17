import 'dart:async';

abstract class PreferencesRepository {
  FutureOr<Map<String, dynamic>?> getToken();
  FutureOr<void> setToken(
      {String? email, String? password, String? accessToken, int? idToken});
  FutureOr<void> clear();
}
