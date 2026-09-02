import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

/// Registers third-party Firebase dependencies in GetIt.
@module
abstract class FirebaseModule {
  @lazySingleton
  FirebaseAuth get auth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
