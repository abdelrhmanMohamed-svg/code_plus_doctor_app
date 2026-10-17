import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../../../core/error/error_mapper.dart';
import '../../../../../core/models/appointment.dart';
import '../../../../../core/models/doctor.dart';
import '../../../../../core/utils/pref_helper.dart';
import '../../../../common/profile/data/repo/user_repository.dart';
import '../../data/repo/appointment_booking_repository.dart';
import 'appointment_booking_state.dart';

@injectable
class AppointmentBookingCubit extends Cubit<AppointmentBookingState> {
  AppointmentBookingCubit(
    this._repository,
    this._userRepository,
  ) : super(const AppointmentBookingState());

  final AppointmentBookingRepository _repository;
  final UserRepository _userRepository;

  Doctor? _doctor;

  Future<void> load(Doctor doctor) async {
    _doctor = doctor;
    emit(state.copyWith(isLoading: true, errorCode: ''));

    try {
      final existingAppointments = await _repository.getDoctorAppointments(
        doctor.id,
      );
      final clinicLocation = await PrefHelper.getClinicLocation();

      final now = DateTime.now();
      final dates = List.generate(30, (i) => now.add(Duration(days: i)));

      final Map<String, List<String>> slotsPerDate = {};

      for (final date in dates) {
        final dayName = DateFormat('EEEE').format(date);
        final dateStr = DateFormat('yyyy-MM-dd').format(date);

        if (doctor.workingDays.contains(dayName)) {
          final slots = _generateSlots(
            doctor.startTime,
            doctor.endTime,
            doctor.slotDuration,
            date,
          );

          final bookedSlots = existingAppointments
              .where(
                (a) =>
                    a.date == dateStr &&
                    a.status != AppointmentStatus.cancelled,
              )
              .map((a) => a.time)
              .toSet();

          final availableSlots = slots
              .where((s) => !bookedSlots.contains(s))
              .toList();
          slotsPerDate[dateStr] = availableSlots;
        } else {
          slotsPerDate[dateStr] = [];
        }
      }

      emit(
        state.copyWith(
          isLoading: false,
          availableDates: dates,
          availableSlotsPerDate: slotsPerDate,
          selectedDate: dates.first,
          clinicLocation: clinicLocation,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(isLoading: false, errorCode: mapError(e)));
    }
  }

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date, selectedTime: null));
  }

  void selectTime(String time) {
    emit(state.copyWith(selectedTime: time));
  }

  Future<void> confirmBooking() async {
    if (_doctor == null ||
        state.selectedDate == null ||
        state.selectedTime == null) {
      return;
    }

    emit(state.copyWith(isLoading: true, errorCode: ''));
    try {
      final user = await _userRepository.fetchCurrentUserProfile();
      if (user == null) throw Exception('User not found');

      final dateStr = DateFormat('yyyy-MM-dd').format(state.selectedDate!);
      final clinicLocation = state.clinicLocation.isNotEmpty
          ? state.clinicLocation
          : await PrefHelper.getClinicLocation();

      final appointment = Appointment(
        id: '',
        patientId: user.uid,
        patientName: user.name,
        patientPhotoUrl: user.imageUrl ?? '',
        patientEmail: user.email,
        doctorId: _doctor!.id,
        doctorName: _doctor!.name,
        doctorSpecialty: _doctor!.specialty,
        doctorPhotoUrl: _doctor!.photo,
        date: dateStr,
        time: state.selectedTime!,
        fee: _doctor!.price,
        status: AppointmentStatus.upcoming,
        clinicLocation: clinicLocation,
      );

      await _repository.createAppointment(appointment);

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } on Exception catch (e) {
      emit(state.copyWith(isLoading: false, errorCode: mapError(e)));
    }
  }

  List<String> _generateSlots(
    String startTimeStr,
    String endTimeStr,
    int durationMin,
    DateTime targetDate,
  ) {
    try {
      final format = DateFormat('hh:mm a');
      final startTime = format.parse(startTimeStr);
      final endTime = format.parse(endTimeStr);

      final now = DateTime.now();
      final isToday =
          targetDate.year == now.year &&
          targetDate.month == now.month &&
          targetDate.day == now.day;
      final currentMinutes = now.hour * 60 + now.minute;

      final slots = <String>[];
      var current = startTime;
      while (current.isBefore(endTime)) {
        final slotMinutes = current.hour * 60 + current.minute;
        if (!isToday || slotMinutes > currentMinutes) {
          slots.add(format.format(current));
        }
        current = current.add(Duration(minutes: durationMin));
      }
      return slots;
    } catch (_) {
      return [];
    }
  }
}
