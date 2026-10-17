import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/models/doctor.dart';

/// Firestore transport — doctors collection only.
@lazySingleton
class ManageDoctorService {
  ManageDoctorService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const _collection = 'doctors';
  static const _adminId = 'adminId';

  Future<List<Doctor>> getDoctorsByAdmin(
    String adminId, {
    String specialty = '',
  }) async {
    Query query = _firestore
        .collection(_collection)
        .where(_adminId, isEqualTo: adminId);
    if (specialty.isNotEmpty) {
      query = query.where('specialty', isEqualTo: specialty);
    }
    final snapshot = await query.get();
    return snapshot.docs
        .map(
          (doc) => Doctor.fromJson(doc.id, doc.data() as Map<String, dynamic>),
        )
        .toList();
  }

  /// Generates a brand-new Firestore document id client-side (no network call).
  String newDoctorId() => _firestore.collection(_collection).doc().id;

  Future<void> createDoctor(Doctor doctor) async {
    await _firestore
        .collection(_collection)
        .doc(doctor.id)
        .set(doctor.toJson());
  }

  /// Merges the form-editable fields, preserving any data written by
  /// other features (counters...) on the document.
  Future<void> updateDoctor({
    required String id,
    required String name,
    required String specialty,
    required String price,
    required bool isActive,
    String? photoUrl,
  }) async {
    final Map<String, dynamic> data = {
      'name': name,
      'specialty': specialty,
      'price': price,
      'isActive': isActive,
    };
    if (photoUrl != null) data['photo'] = photoUrl;

    await _firestore
        .collection(_collection)
        .doc(id)
        .set(data, SetOptions(merge: true));
  }

  Future<void> updateDoctorAvailability({
    required String id,
    required List<String> workingDays,
    required String startTime,
    required String endTime,
    required int slotDuration,
  }) async {
    await _firestore.collection(_collection).doc(id).set({
      'workingDays': workingDays,
      'startTime': startTime,
      'endTime': endTime,
      'slotDuration': slotDuration,
    }, SetOptions(merge: true));
  }

  Future<void> deleteDoctor(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }
}
