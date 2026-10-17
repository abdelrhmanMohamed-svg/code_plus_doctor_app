import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'role.dart';

/// User profile stored in Firestore at `users/{uid}`.
class UserProfile {
  const UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
    this.role = Role.patient,
    this.imageUrl,
    this.clinicLocation,
    this.contactNumber,
    this.phone,
    this.favoriteDoctorIds = const [],
  });

  final String uid;
  final String name;
  final String email;
  final DateTime createdAt;
  final Role role;
  final String? imageUrl;
  final String? clinicLocation;
  final String? contactNumber;
  final String? phone;
  final List<String> favoriteDoctorIds;

  UserProfile copyWith({
    String? uid,
    String? name,
    String? email,
    DateTime? createdAt,
    Role? role,
    String? imageUrl,
    String? clinicLocation,
    String? contactNumber,
    String? phone,
    List<String>? favoriteDoctorIds,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
      clinicLocation: clinicLocation ?? this.clinicLocation,
      contactNumber: contactNumber ?? this.contactNumber,
      phone: phone ?? this.phone,
      favoriteDoctorIds: favoriteDoctorIds ?? this.favoriteDoctorIds,
    );
  }

  factory UserProfile.fromJson(String uid, Map<String, dynamic> data) {
    DateTime parsedDate = DateTime.now();
    final createdAtData = data['createdAt'];
    if (createdAtData is Timestamp) {
      parsedDate = createdAtData.toDate();
    } else if (createdAtData is String) {
      parsedDate = DateTime.tryParse(createdAtData) ?? DateTime.now();
    }

    return UserProfile(
      uid: uid,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      createdAt: parsedDate,
      role: _mapRole(data['role'] as String?),
      imageUrl: data['imageUrl'] as String?,
      clinicLocation: data['clinicLocation'] as String?,
      contactNumber: data['contactNumber'] as String?,
      phone: data['phone'] as String?,
      favoriteDoctorIds: (data['favoriteDoctorIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'createdAt': createdAt,
        'role': role.name,
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (clinicLocation != null) 'clinicLocation': clinicLocation,
        if (contactNumber != null) 'contactNumber': contactNumber,
        if (phone != null) 'phone': phone,
        'favoriteDoctorIds': favoriteDoctorIds,
      };

  static Role _mapRole(String? value) {
    if (value == null) return Role.patient;

    final Map<String, Role> rolesMap = Role.values.asNameMap();
    return rolesMap[value.toLowerCase()] ?? Role.patient;
  }

  @override
  bool operator ==(Object other) =>
      other is UserProfile &&
      other.uid == uid &&
      other.name == name &&
      other.email == email &&
      other.role == role &&
      other.imageUrl == imageUrl &&
      other.clinicLocation == clinicLocation &&
      other.contactNumber == contactNumber &&
      other.phone == phone &&
      listEquals(other.favoriteDoctorIds, favoriteDoctorIds);

  @override
  int get hashCode => Object.hash(uid, name, email, role, imageUrl, clinicLocation, contactNumber, phone, Object.hashAll(favoriteDoctorIds));
}
