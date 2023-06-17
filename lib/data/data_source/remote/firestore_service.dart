import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
class FirestoreService {
  FirebaseFirestore get service => FirebaseFirestore.instance;
}
