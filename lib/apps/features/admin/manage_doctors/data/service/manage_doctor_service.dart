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
}
