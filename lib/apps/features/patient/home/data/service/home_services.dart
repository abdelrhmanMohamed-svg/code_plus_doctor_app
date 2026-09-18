import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/models/doctor.dart';

/// Firestore transport — active doctors for the patient home screen.
@lazySingleton
class HomeService {
  HomeService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const _collection = 'doctors';
  static const _isActiveKey = "isActive";

  Future<List<Doctor>> getActiveDoctors() async {
    final snapshot = await _firestore
        .collection(_collection)
        .where(_isActiveKey, isEqualTo: true)
        .get();
    return snapshot.docs
        .map((doc) => Doctor.fromJson(doc.id, doc.data()))
        .toList();
  }
}
