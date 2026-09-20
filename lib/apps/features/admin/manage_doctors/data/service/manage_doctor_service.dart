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

  Future<List<Doctor>> getDoctorsByAdmin(String adminId) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where(_adminId, isEqualTo: adminId)
        .get();
    return snapshot.docs
        .map((doc) => Doctor.fromJson(doc.id, doc.data()))
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

  /// Merges only the form-editable fields, preserving any data written by
  /// other features (price, photo, isActive, counters...) on the document.
  Future<void> updateDoctor({
    required String id,
    required String name,
    required String specialty,
  }) async {
    await _firestore.collection(_collection).doc(id).set({
      'name': name,
      'specialty': specialty,
    }, SetOptions(merge: true));
  }

  Future<void> deleteDoctor(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }
}
