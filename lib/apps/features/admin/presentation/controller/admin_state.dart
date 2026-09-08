import '../../../../core/models/doctor.dart';

class AdminState {
  const AdminState({
    this.doctors = const [],
    this.isLoading = false,
    this.searchQuery = '',
    this.filterSpecialty = '',
    this.hasError = false,
    this.errorMessage,
  });

  final List<Doctor> doctors;
  final bool isLoading;
  final String searchQuery;
  final String filterSpecialty;
  final bool hasError;
  final String? errorMessage;

  int get totalDoctors => doctors.length;
  int get activeDoctors => doctors.where((d) => d.isActive).length;
  bool get hasActiveFilter =>
      searchQuery.isNotEmpty || filterSpecialty.isNotEmpty;

  AdminState copyWith({
    List<Doctor>? doctors,
    bool? isLoading,
    String? searchQuery,
    String? filterSpecialty,
    bool? hasError,
    String? errorMessage,
  }) {
    return AdminState(
      doctors: doctors ?? this.doctors,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      filterSpecialty: filterSpecialty ?? this.filterSpecialty,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AdminState &&
      other.doctors == doctors &&
      other.isLoading == isLoading &&
      other.searchQuery == searchQuery &&
      other.filterSpecialty == filterSpecialty &&
      other.hasError == hasError &&
      other.errorMessage == errorMessage;

  @override
  int get hashCode => Object.hash(
    doctors,
    isLoading,
    searchQuery,
    filterSpecialty,
    hasError,
    errorMessage,
  );
}
