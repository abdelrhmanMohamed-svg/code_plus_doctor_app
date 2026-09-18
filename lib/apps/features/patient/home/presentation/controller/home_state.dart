import '../../../../../core/models/doctor.dart';

/// Immutable state for the active doctors on the patient home screen.
class HomeState {
  const HomeState({
    this.doctors = const [],
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
  });

  final List<Doctor> doctors;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;

  HomeState copyWith({
    List<Doctor>? doctors,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return HomeState(
      doctors: doctors ?? this.doctors,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is HomeState &&
      other.doctors == doctors &&
      other.isLoading == isLoading &&
      other.hasError == hasError &&
      other.errorMessage == errorMessage;

  @override
  int get hashCode => Object.hash(doctors, isLoading, hasError, errorMessage);
}
