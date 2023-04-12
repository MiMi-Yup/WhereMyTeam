import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@singleton
class FirebaseAuthService {
  FirebaseAuth get service => FirebaseAuth.instance;
  bool assignEvent = false;
}
