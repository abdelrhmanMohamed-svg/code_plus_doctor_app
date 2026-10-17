import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/error_mapper.dart';
import '../../../../../core/models/appointment.dart';
import '../../../../common/appointments/data/repo/appointments_repository.dart';
import '../../../../common/profile/data/repo/user_repository.dart';
import 'patient_appointments_state.dart';

@injectable
class PatientAppointmentsCubit extends Cubit<PatientAppointmentsState> {
  PatientAppointmentsCubit(
    this._repository,
    this._userRepository,
  ) : super(const PatientAppointmentsState());

  final AppointmentsRepository _repository;
  final UserRepository _userRepository;

  Future<void> loadAppointments() async {
    final profile = await _userRepository.fetchCurrentUserProfile();
    final patientId = profile?.uid;
    if (patientId == null) return;

    emit(state.copyWith(isLoading: true, hasError: false, errorMessage: null));
    try {
      final appointments = await _repository.getPatientAppointments(patientId);
      emit(state.copyWith(appointments: appointments, isLoading: false));
    } on Exception catch (e) {
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: mapError(e),
      ));
    }
  }

  Future<void> cancelAppointment(String appointmentId) async {
    try {
      await _repository.updateAppointmentStatus(appointmentId, AppointmentStatus.cancelled);
      await loadAppointments();
    } on Exception catch (e) {
      emit(state.copyWith(
        hasError: true,
        errorMessage: mapError(e),
      ));
    }
  }

  Future<void> submitRating(String appointmentId, String doctorId, double rating, String? comment) async {
    try {
      final appointment = state.appointments.firstWhere(
        (a) => a.id == appointmentId,
        orElse: () => throw Exception('Appointment not found'),
      );
      if (appointment.status != AppointmentStatus.completed) {
        throw Exception('Only completed appointments can be rated.');
      }

      await _repository.submitRating(appointmentId, doctorId, rating, comment);
      await loadAppointments();
    } on Exception catch (e) {
      emit(state.copyWith(
        hasError: true,
        errorMessage: mapError(e),
      ));
    }
  }
}
