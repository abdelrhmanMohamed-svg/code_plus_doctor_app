import 'package:flutter/foundation.dart';

class AppointmentBookingState {
  const AppointmentBookingState({
    this.isLoading = true,
    this.errorCode = '',
    this.availableDates = const [],
    this.availableSlotsPerDate = const {},
    this.selectedDate,
    this.selectedTime,
    this.clinicLocation = '',
    this.isSuccess = false,
  });

  final bool isLoading;
  final String errorCode;
  final List<DateTime> availableDates;
  final Map<String, List<String>> availableSlotsPerDate;
  final DateTime? selectedDate;
  final String? selectedTime;
  final String clinicLocation;
  final bool isSuccess;

  AppointmentBookingState copyWith({
    bool? isLoading,
    String? errorCode,
    List<DateTime>? availableDates,
    Map<String, List<String>>? availableSlotsPerDate,
    DateTime? selectedDate,
    String? selectedTime,
    String? clinicLocation,
    bool? isSuccess,
  }) {
    return AppointmentBookingState(
      isLoading: isLoading ?? this.isLoading,
      errorCode: errorCode ?? this.errorCode,
      availableDates: availableDates ?? this.availableDates,
      availableSlotsPerDate: availableSlotsPerDate ?? this.availableSlotsPerDate,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      clinicLocation: clinicLocation ?? this.clinicLocation,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AppointmentBookingState &&
      other.isLoading == isLoading &&
      other.errorCode == errorCode &&
      listEquals(other.availableDates, availableDates) &&
      mapEquals(other.availableSlotsPerDate, availableSlotsPerDate) &&
      other.selectedDate == selectedDate &&
      other.selectedTime == selectedTime &&
      other.clinicLocation == clinicLocation &&
      other.isSuccess == isSuccess;

  @override
  int get hashCode => Object.hash(
        isLoading,
        errorCode,
        Object.hashAll(availableDates),
        Object.hashAll(availableSlotsPerDate.keys),
        Object.hashAll(availableSlotsPerDate.values.expand((e) => e)),
        selectedDate,
        selectedTime,
        clinicLocation,
        isSuccess,
      );
}
