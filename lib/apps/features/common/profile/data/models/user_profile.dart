import 'package:cloud_firestore/cloud_firestore.dart';

import 'role.dart';

/// User profile stored in Firestore at `users/{uid}`.
class UserProfile {
  const UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
    this.role = Role.patient,
  });

  final String uid;
  final String name;
  final String email;
  final DateTime createdAt;
  final Role role;

  factory UserProfile.fromJson(String uid, Map<String, dynamic> data) {
    return UserProfile(
      uid: uid,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      role: _mapRole(data['role'] as String?),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'createdAt': createdAt,
    'role': role.name,
  };

  static Role _mapRole(String? value) {
    if (value == null) return Role.patient;

    final Map<String, Role> rolesMap = Role.values.asNameMap();
    return rolesMap[value] ?? Role.patient;
  }

  @override
  bool operator ==(Object other) =>
      other is UserProfile &&
      other.uid == uid &&
      other.name == name &&
      other.email == email &&
      other.role == role;

  @override
  int get hashCode => Object.hash(uid, name, email, role);
}
