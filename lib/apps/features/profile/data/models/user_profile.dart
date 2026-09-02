import 'package:cloud_firestore/cloud_firestore.dart';

/// User profile stored in Firestore at `users/{uid}`.
class UserProfile {
  const UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  final String uid;
  final String name;
  final String email;
  final DateTime createdAt;

  factory UserProfile.fromDoc(String uid, Map<String, dynamic> data) {
    return UserProfile(
      uid: uid,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toDoc() => {
    'name': name,
    'email': email,
    'createdAt': createdAt,
  };

  @override
  bool operator ==(Object other) =>
      other is UserProfile &&
      other.uid == uid &&
      other.name == name &&
      other.email == email;

  @override
  int get hashCode => Object.hash(uid, name, email);
}
