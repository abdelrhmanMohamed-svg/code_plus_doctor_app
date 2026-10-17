import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/error_mapper.dart';
import '../../../../common/profile/data/repo/user_repository.dart';
import '../../data/repo/find_doctors_repository.dart';
import 'find_doctor_state.dart';

/// Tracks favorited doctors and manages doctor search on the Find Doctors screen.
@injectable
class FindDoctorCubit extends Cubit<FindDoctorState> {
  FindDoctorCubit(this._repository, this._userRepository) : super(const FindDoctorState());

  final FindDoctorsRepository _repository;
  final UserRepository _userRepository;

  Future<void> loadDoctors() async {
    emit(
      state.copyWith(
        isLoading: true,
        hasError: false,
        errorMessage: null,
      ),
    );
    try {
      final doctors = await _repository.fetchDoctors();
      final profile = await _userRepository.fetchCurrentUserProfile();
      
      emit(
        state.copyWith(
          isLoading: false,
          allDoctors: doctors,
          filteredDoctors: doctors,
          searchQuery: '',
          filterSpecialty: '',
          favoritedIds: (profile?.favoriteDoctorIds ?? const []).toSet(),
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
    _applyFilters(query: query, filterSpecialty: state.filterSpecialty);
  }

  void setSpecialtyFilter(String specialty) {
    _applyFilters(query: state.searchQuery, filterSpecialty: specialty);
  }

  void _applyFilters({
    required String query,
    required String filterSpecialty,
  }) {
    final lowerQuery = query.toLowerCase().trim();
    final filtered = state.allDoctors.where((doc) {
      final matchesQuery = lowerQuery.isEmpty ||
          doc.name.toLowerCase().contains(lowerQuery) ||
          doc.specialty.toLowerCase().contains(lowerQuery);
      final matchesSpecialty =
          filterSpecialty.isEmpty || doc.specialty == filterSpecialty;
      return matchesQuery && matchesSpecialty;
    }).toList();

    emit(
      state.copyWith(
        searchQuery: query,
        filterSpecialty: filterSpecialty,
        filteredDoctors: filtered,
      ),
    );
  }

  void setInitialFavorites(Iterable<String> ids) {
    if (state.favoritedIds.isNotEmpty) return;
    emit(state.copyWith(favoritedIds: {...ids}));
  }

  Future<void> toggleFavorite(String id) async {
    final originalIds = {...state.favoritedIds};
    final newIds = {...state.favoritedIds};
    
    if (!newIds.remove(id)) newIds.add(id);
    
    // Optimistic update
    emit(state.copyWith(favoritedIds: newIds));
    
    try {
      final profile = await _userRepository.fetchCurrentUserProfile();
      if (profile != null) {
        await _userRepository.updateUserProfile(
          profile.copyWith(favoriteDoctorIds: newIds.toList()),
        );
      }
    } catch (e) {
      // Revert on error
      emit(state.copyWith(favoritedIds: originalIds));
    }
  }
}
