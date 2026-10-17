import 'package:flutter/foundation.dart';
import '../../../../../core/models/doctor.dart';

/// Immutable state tracking which doctors are favorited and loaded on the
/// Find Doctors screen.
class FindDoctorState {
  const FindDoctorState({
    this.favoritedIds = const {},
    this.isLoading = true,
    this.hasError = false,
    this.errorMessage,
    this.allDoctors = const [],
    this.filteredDoctors = const [],
    this.searchQuery = '',
    this.filterSpecialty = '',
  });

  final Set<String> favoritedIds;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final List<Doctor> allDoctors;
  final List<Doctor> filteredDoctors;
  final String searchQuery;
  final String filterSpecialty;

  bool isFavorited(String id) => favoritedIds.contains(id);
  bool get hasActiveFilter =>
      searchQuery.isNotEmpty || filterSpecialty.isNotEmpty;

  FindDoctorState copyWith({
    Set<String>? favoritedIds,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    List<Doctor>? allDoctors,
    List<Doctor>? filteredDoctors,
    String? searchQuery,
    String? filterSpecialty,
  }) {
    return FindDoctorState(
      favoritedIds: favoritedIds ?? this.favoritedIds,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      allDoctors: allDoctors ?? this.allDoctors,
      filteredDoctors: filteredDoctors ?? this.filteredDoctors,
      searchQuery: searchQuery ?? this.searchQuery,
      filterSpecialty: filterSpecialty ?? this.filterSpecialty,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FindDoctorState &&
        setEquals(other.favoritedIds, favoritedIds) &&
        other.isLoading == isLoading &&
        other.hasError == hasError &&
        other.errorMessage == errorMessage &&
        listEquals(other.allDoctors, allDoctors) &&
        listEquals(other.filteredDoctors, filteredDoctors) &&
        other.searchQuery == searchQuery &&
        other.filterSpecialty == filterSpecialty;
  }

  @override
  int get hashCode {
    return favoritedIds.hashCode ^
        isLoading.hashCode ^
        hasError.hashCode ^
        errorMessage.hashCode ^
        allDoctors.hashCode ^
        filteredDoctors.hashCode ^
        searchQuery.hashCode ^
        filterSpecialty.hashCode;
  }
}
