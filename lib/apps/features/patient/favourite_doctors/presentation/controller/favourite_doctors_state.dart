import 'package:flutter/foundation.dart';
import '../../../../../core/models/doctor.dart';

/// Immutable state tracking which doctors are favorited on the
/// Favourite Doctors screen, as well as the list of doctors.
class FavouriteDoctorsState {
  const FavouriteDoctorsState({
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
    this.favoritedIds = const {},
    this.allFavoriteDoctors = const [],
    this.filteredFavoriteDoctors = const [],
    this.searchQuery = '',
  });

  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final Set<String> favoritedIds;
  final List<Doctor> allFavoriteDoctors;
  final List<Doctor> filteredFavoriteDoctors;
  final String searchQuery;

  bool isFavorited(String id) => favoritedIds.contains(id);

  FavouriteDoctorsState copyWith({
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    Set<String>? favoritedIds,
    List<Doctor>? allFavoriteDoctors,
    List<Doctor>? filteredFavoriteDoctors,
    String? searchQuery,
  }) =>
      FavouriteDoctorsState(
        isLoading: isLoading ?? this.isLoading,
        hasError: hasError ?? this.hasError,
        errorMessage: errorMessage ?? this.errorMessage,
        favoritedIds: favoritedIds ?? this.favoritedIds,
        allFavoriteDoctors: allFavoriteDoctors ?? this.allFavoriteDoctors,
        filteredFavoriteDoctors: filteredFavoriteDoctors ?? this.filteredFavoriteDoctors,
        searchQuery: searchQuery ?? this.searchQuery,
      );

  @override
  bool operator ==(Object other) =>
      other is FavouriteDoctorsState &&
      other.isLoading == isLoading &&
      other.hasError == hasError &&
      other.errorMessage == errorMessage &&
      setEquals(other.favoritedIds, favoritedIds) &&
      listEquals(other.allFavoriteDoctors, allFavoriteDoctors) &&
      listEquals(other.filteredFavoriteDoctors, filteredFavoriteDoctors) &&
      other.searchQuery == searchQuery;

  @override
  int get hashCode => Object.hash(
        isLoading,
        hasError,
        errorMessage,
        Object.hashAllUnordered(favoritedIds),
        Object.hashAll(allFavoriteDoctors),
        Object.hashAll(filteredFavoriteDoctors),
        searchQuery,
      );
}
