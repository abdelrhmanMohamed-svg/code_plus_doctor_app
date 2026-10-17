import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/models/appointment.dart';

@lazySingleton
class AppointmentBookingService {
  const AppointmentBookingService(this._firestore);

  final FirebaseFirestore _firestore;

  static const _collection = 'appointments';

  Future<void> createAppointment(Appointment appointment) async {
    final docRef = _firestore.collection(_collection).doc();
    final newAppointment = Appointment(
      id: docRef.id,
      patientId: appointment.patientId,
      patientName: appointment.patientName,
      patientPhotoUrl: appointment.patientPhotoUrl,
      patientEmail: appointment.patientEmail,
      doctorId: appointment.doctorId,
      doctorName: appointment.doctorName,
      doctorSpecialty: appointment.doctorSpecialty,
      doctorPhotoUrl: appointment.doctorPhotoUrl,
      date: appointment.date,
      time: appointment.time,
      fee: appointment.fee,
      status: appointment.status,
      clinicLocation: appointment.clinicLocation,
    );
    await docRef.set(newAppointment.toJson());
  }

  Future<List<Appointment>> getDoctorAppointments(String doctorId) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('doctorId', isEqualTo: doctorId)
        .where('status', isEqualTo: 'upcoming')
        .get();

    return snapshot.docs
        .map((doc) => Appointment.fromJson(doc.id, doc.data()))
        .toList();
  }
}
