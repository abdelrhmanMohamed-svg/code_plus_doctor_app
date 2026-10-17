import 'package:flutter/foundation.dart';

enum AvailabilityFormStatus { initial, submitting, success, failure }

class DoctorAvailabilityState {
  const DoctorAvailabilityState({
    this.workingDays = const [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
    ],
    this.startTime = '09:00 AM',
    this.endTime = '05:00 PM',
    this.slotDuration = 30,
    this.status = AvailabilityFormStatus.initial,
    this.errorMessage,
  });

  final List<String> workingDays;
  final String startTime;
  final String endTime;
  final int slotDuration;
  final AvailabilityFormStatus status;
  final String? errorMessage;

  bool get isLoading => status == AvailabilityFormStatus.submitting;
  bool get hasError => status == AvailabilityFormStatus.failure;

  DoctorAvailabilityState copyWith({
    List<String>? workingDays,
    String? startTime,
    String? endTime,
    int? slotDuration,
    AvailabilityFormStatus? status,
    String? errorMessage,
  }) {
    return DoctorAvailabilityState(
      workingDays: workingDays ?? this.workingDays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      slotDuration: slotDuration ?? this.slotDuration,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorAvailabilityState &&
          runtimeType == other.runtimeType &&
          listEquals(workingDays, other.workingDays) &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          slotDuration == other.slotDuration &&
          status == other.status &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(
        Object.hashAll(workingDays),
        startTime,
        endTime,
        slotDuration,
        status,
        errorMessage,
      );
}
