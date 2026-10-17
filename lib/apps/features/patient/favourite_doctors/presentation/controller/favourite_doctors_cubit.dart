import 'package:doctor_hunt/apps/features/patient/find_doctors/data/repo/find_doctors_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/error_mapper.dart';
import '../../../../common/profile/data/repo/user_repository.dart';
import 'favourite_doctors_state.dart';

/// Tracks favorited doctors on the Favourite Doctors screen.
@injectable
class FavouriteDoctorsCubit extends Cubit<FavouriteDoctorsState> {
  FavouriteDoctorsCubit(this._repository, this._userRepository)
    : super(const FavouriteDoctorsState());

  final FindDoctorsRepository _repository;
  final UserRepository _userRepository;

  Future<void> loadDoctors() async {
    emit(state.copyWith(isLoading: true, hasError: false, errorMessage: null));
    try {
      final allDoctors = await _repository.fetchDoctors();
      final profile = await _userRepository.fetchCurrentUserProfile();
      final favoritedIds = (profile?.favoriteDoctorIds ?? const []).toSet();

      final favDoctors = allDoctors
          .where((doc) => favoritedIds.contains(doc.id))
          .map((doc) => doc.copyWith(isFavorited: true))
          .toList();

      emit(
        state.copyWith(
          isLoading: false,
          favoritedIds: favoritedIds,
          allFavoriteDoctors: favDoctors,
          filteredFavoriteDoctors: favDoctors,
          searchQuery: '',
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: mapError(e),
        ),
      );
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      emit(
        state.copyWith(
          searchQuery: query,
          filteredFavoriteDoctors: state.allFavoriteDoctors,
        ),
      );
      return;
    }

    final lowerQuery = query.toLowerCase();
    final filtered = state.allFavoriteDoctors
        .where((doc) => doc.name.toLowerCase().contains(lowerQuery))
        .toList();

    emit(state.copyWith(searchQuery: query, filteredFavoriteDoctors: filtered));
  }

  void setInitialFavorites(Iterable<String> ids) {
    if (state.favoritedIds.isNotEmpty) return;
    emit(state.copyWith(favoritedIds: {...ids}));
  }

  Future<void> toggleFavorite(String id) async {
    final originalIds = {...state.favoritedIds};
    final newIds = {...state.favoritedIds};

    if (!newIds.remove(id)) newIds.add(id);

    // Optimistically update the IDs and the filtered list locally
    final newFavDoctors = state.allFavoriteDoctors
        .where((doc) => newIds.contains(doc.id))
        .toList();
    final newFilteredFavDoctors = state.filteredFavoriteDoctors
        .where((doc) => newIds.contains(doc.id))
        .toList();

    emit(
      state.copyWith(
        favoritedIds: newIds,
        allFavoriteDoctors: newFavDoctors,
        filteredFavoriteDoctors: newFilteredFavDoctors,
      ),
    );

    try {
      final profile = await _userRepository.fetchCurrentUserProfile();
      if (profile != null) {
        await _userRepository.updateUserProfile(
          profile.copyWith(favoriteDoctorIds: newIds.toList()),
        );
      }
    } catch (e) {
      // Revert on error
      final originalFavDoctors = state.allFavoriteDoctors
          .where((doc) => originalIds.contains(doc.id))
          .toList();
      final originalFiltered = state.filteredFavoriteDoctors
          .where((doc) => originalIds.contains(doc.id))
          .toList();
      emit(
        state.copyWith(
          favoritedIds: originalIds,
          allFavoriteDoctors: originalFavDoctors,
          filteredFavoriteDoctors: originalFiltered,
        ),
      );
    }
  }
}
