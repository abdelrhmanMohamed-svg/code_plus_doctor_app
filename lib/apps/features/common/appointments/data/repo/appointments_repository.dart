import '../../../../../core/models/appointment.dart';

abstract class AppointmentsRepository {
  Future<List<Appointment>> getAppointments();
  Future<List<Appointment>> getPatientAppointments(String patientId);
  Future<void> updateAppointmentStatus(String appointmentId, AppointmentStatus status);
  Future<void> submitRating(String appointmentId, String doctorId, double rating, String? comment);
}
