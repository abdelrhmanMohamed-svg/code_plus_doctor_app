import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/models/doctor.dart';

/// Firestore transport — creates doctors in the `doctors` collection.
@lazySingleton
class CreateDoctorService {
  CreateDoctorService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const _collection = 'doctors';

  Future<String> addDoctor(Doctor doctor) async {
    final doc = await _firestore.collection(_collection).add(doctor.toJson());
    return doc.id;
  }
}
