import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:intl/intl.dart';

import '../../../../../core/error/error_mapper.dart';
import '../../../../../core/models/doctor.dart';
import '../../data/repo/doctor_repository.dart';
import 'doctor_availability_state.dart';

@injectable
class DoctorAvailabilityCubit extends Cubit<DoctorAvailabilityState> {
  DoctorAvailabilityCubit(this._repository)
      : super(const DoctorAvailabilityState());

  final DoctorRepository _repository;

  void init(Doctor doctor) {
    emit(
      state.copyWith(
        workingDays: doctor.workingDays,
        startTime: doctor.startTime,
        endTime: doctor.endTime,
        slotDuration: doctor.slotDuration,
        status: AvailabilityFormStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void toggleDay(String day) {
    final days = List<String>.from(state.workingDays);
    if (days.contains(day)) {
      days.remove(day);
    } else {
      days.add(day);
    }
    emit(state.copyWith(workingDays: days));
  }

  void updateStartTime(String time) {
    emit(state.copyWith(startTime: time));
  }

  void updateEndTime(String time) {
    emit(state.copyWith(endTime: time));
  }

  void updateSlotDuration(int duration) {
    emit(state.copyWith(slotDuration: duration));
  }

  Future<void> submit(String doctorId) async {
    if (state.workingDays.isEmpty) {
      emit(
        state.copyWith(
          status: AvailabilityFormStatus.failure,
          errorMessage: 'Please select at least one working day',
        ),
      );
      return;
    }

    try {
      final format = DateFormat('hh:mm a');
      final start = format.parse(state.startTime);
      final end = format.parse(state.endTime);
      if (!start.isBefore(end)) {
        emit(
          state.copyWith(
            status: AvailabilityFormStatus.failure,
            errorMessage: 'Start time must be before end time',
          ),
        );
        return;
      }
    } catch (_) {}

    emit(
      state.copyWith(
        status: AvailabilityFormStatus.submitting,
        errorMessage: null,
      ),
    );
    try {
      await _repository.saveDoctorAvailability(
        id: doctorId,
        workingDays: state.workingDays,
        startTime: state.startTime,
        endTime: state.endTime,
        slotDuration: state.slotDuration,
      );
      emit(state.copyWith(status: AvailabilityFormStatus.success));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: AvailabilityFormStatus.failure,
          errorMessage: mapError(e),
        ),
      );
    }
  }
}
