import 'package:injectable/injectable.dart';

import '../../../../../core/models/appointment.dart';
import '../service/appointment_booking_service.dart';

abstract class AppointmentBookingRepository {
  Future<void> createAppointment(Appointment appointment);
  Future<List<Appointment>> getDoctorAppointments(String doctorId);
}

@LazySingleton(as: AppointmentBookingRepository)
class AppointmentBookingRepositoryImpl implements AppointmentBookingRepository {
  const AppointmentBookingRepositoryImpl(this._service);

  final AppointmentBookingService _service;

  @override
  Future<void> createAppointment(Appointment appointment) {
    return _service.createAppointment(appointment);
  }

  @override
  Future<List<Appointment>> getDoctorAppointments(String doctorId) {
    return _service.getDoctorAppointments(doctorId);
  }
}
