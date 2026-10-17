import '../../../../../core/models/appointment.dart';

class AdminAppointmentsState {
  const AdminAppointmentsState({
    this.appointments = const [],
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
  });

  final List<Appointment> appointments;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;

  List<Appointment> get upcoming =>
      appointments.where((a) => a.status == AppointmentStatus.upcoming).toList();

  List<Appointment> get completed =>
      appointments.where((a) => a.status == AppointmentStatus.completed).toList();

  List<Appointment> get cancelled =>
      appointments.where((a) => a.status == AppointmentStatus.cancelled).toList();

  AdminAppointmentsState copyWith({
    List<Appointment>? appointments,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return AdminAppointmentsState(
      appointments: appointments ?? this.appointments,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AdminAppointmentsState &&
      other.appointments == appointments &&
      other.isLoading == isLoading &&
      other.hasError == hasError &&
      other.errorMessage == errorMessage;

  @override
  int get hashCode => Object.hash(
        appointments,
        isLoading,
        hasError,
        errorMessage,
      );
}
