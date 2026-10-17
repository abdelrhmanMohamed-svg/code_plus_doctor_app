import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/error_mapper.dart';
import '../../../../../core/models/appointment.dart';
import '../../../../common/appointments/data/repo/appointments_repository.dart';
import 'admin_appointments_state.dart';

@injectable
class AdminAppointmentsCubit extends Cubit<AdminAppointmentsState> {
  AdminAppointmentsCubit(this._repository) : super(const AdminAppointmentsState());

  final AppointmentsRepository _repository;

  Future<void> loadAppointments() async {
    emit(state.copyWith(isLoading: true, hasError: false, errorMessage: null));
    try {
      final appointments = await _repository.getAppointments();
      emit(state.copyWith(appointments: appointments, isLoading: false));
    } on Exception catch (e) {
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: mapError(e),
      ));
    }
  }

  Future<void> updateStatus(String appointmentId, AppointmentStatus status) async {
    try {
      await _repository.updateAppointmentStatus(appointmentId, status);
      await loadAppointments();
    } on Exception catch (e) {
      emit(state.copyWith(
        hasError: true,
        errorMessage: mapError(e),
      ));
    }
  }
}
