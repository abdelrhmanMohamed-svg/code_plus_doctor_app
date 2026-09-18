import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/user_profile.dart';

/// Firestore transport — user profile CRUD only.
@lazySingleton
class UserService {
  UserService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const _collection = 'users';

  Future<void> createUserProfile(UserProfile profile) {
    return _firestore.collection(_collection).doc(profile.uid).set({
      ...profile.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    final doc = await _firestore.collection(_collection).doc(uid).get();
    if (!doc.exists) return null;
    return UserProfile.fromJson(doc.id, doc.data()!);
  }
}
