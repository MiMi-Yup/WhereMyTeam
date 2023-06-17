import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:where_my_team/data/data_source/local/secure_preferences_service.dart';
import 'package:where_my_team/domain/repositories/preferences_repository.dart';

@Injectable(as: PreferencesRepository)
class PreferencesRepositoryImpl implements PreferencesRepository {
  final SecurePreferencesService storage;

  PreferencesRepositoryImpl({required this.storage});

  @override
  FutureOr<void> clear() async {
    await storage.clear();
  }

  @override
  FutureOr<Map<String, dynamic>?> getToken() async {
    String? token = await storage.readValue('accessToken');
    if (token == null) return null;
    return json.decode(token) as Map<String, dynamic>?;
  }

  @override
  FutureOr<void> setToken(
      {String? email, String? password, String? accessToken, int? idToken}) {
    if (accessToken != null && idToken != null) {
      return storage.writeValue(
          "accessToken",
          json.encode({
            'type': 'google',
            'accessToken': accessToken,
            'idToken': idToken
          }));
    } else if (email != null && password != null) {
      return storage.writeValue("accessToken",
          json.encode({'type': 'email', 'email': email, 'password': password}));
    } else {
      throw ArgumentError("Invalid token to store");
    }
  }
}
