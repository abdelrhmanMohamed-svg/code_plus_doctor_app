import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/models/appointment.dart';
import 'appointments_repository.dart';

@LazySingleton(as: AppointmentsRepository)
class AppointmentsRepositoryImpl implements AppointmentsRepository {
  AppointmentsRepositoryImpl(this._firestore);

  final FirebaseFirestore _firestore;

  static const _collection = 'appointments';
  static const _reviewsCollection = 'reviews';
  static const _doctorsCollection = 'doctors';

  @override
  Future<List<Appointment>> getAppointments() async {
    final snapshot = await _firestore.collection(_collection).get();
    return snapshot.docs
        .map((doc) => Appointment.fromJson(doc.id, doc.data()))
        .toList();
  }

  @override
  Future<List<Appointment>> getPatientAppointments(String patientId) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('patientId', isEqualTo: patientId)
        .get();
    return snapshot.docs
        .map((doc) => Appointment.fromJson(doc.id, doc.data()))
        .toList();
  }

  @override
  Future<void> updateAppointmentStatus(
    String appointmentId,
    AppointmentStatus status,
  ) async {
    await _firestore.collection(_collection).doc(appointmentId).update({
      'status': status.name,
    });
  }

  @override
  Future<void> submitRating(
    String appointmentId,
    String doctorId,
    double rating,
    String? comment,
  ) async {
    final appointmentRef =
        _firestore.collection(_collection).doc(appointmentId);
    final doctorRef = _firestore.collection(_doctorsCollection).doc(doctorId);
    final reviewRef = _firestore.collection(_reviewsCollection).doc();

    await _firestore.runTransaction((transaction) async {
      final docSnapshot = await transaction.get(doctorRef);
      if (!docSnapshot.exists) {
        throw Exception('Doctor not found');
      }
      final appointmentSnapshot = await transaction.get(appointmentRef);
      if (!appointmentSnapshot.exists) {
        throw Exception('Appointment not found');
      }

      final docData = docSnapshot.data()!;
      final currentCount = (docData['reviewsCount'] as num?)?.toInt() ?? 0;
      final currentAvg = (docData['rating'] as num?)?.toDouble() ?? 0.0;

      final newCount = currentCount + 1;
      final newAvg = ((currentAvg * currentCount) + rating) / newCount;

      transaction.update(doctorRef, {
        'reviewsCount': newCount,
        'rating': newAvg,
      });

      transaction.update(appointmentRef, {
        'rating': rating,
        if (comment != null && comment.isNotEmpty) 'reviewComment': comment,
      });

      final appointmentData = appointmentSnapshot.data()!;
      final patientId = appointmentData['patientId'];

      transaction.set(reviewRef, {
        'id': reviewRef.id,
        'appointmentId': appointmentId,
        'patientId': patientId,
        'doctorId': doctorId,
        'rating': rating,
        'comment': comment ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }
}

typedef AppointmentsRepositoryImple = AppointmentsRepositoryImpl;

