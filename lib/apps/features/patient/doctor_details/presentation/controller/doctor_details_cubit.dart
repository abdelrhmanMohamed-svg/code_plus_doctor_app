import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/error_mapper.dart';
import '../../../../common/profile/data/repo/user_repository.dart';
import 'doctor_details_state.dart';

/// Tracks favorited doctors on the Doctor Details screen.
@injectable
class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  DoctorDetailsCubit(this._userRepository) : super(const DoctorDetailsState());

  final UserRepository _userRepository;

  Future<void> loadFavoriteStatus(
    String doctorId, {
    bool? initialIsFavorited,
  }) async {
    if (initialIsFavorited != null) {
      emit(state.copyWith(favoritedIds: initialIsFavorited ? {doctorId} : const {}));
    }
    try {
      final profile = await _userRepository.fetchCurrentUserProfile();
      final isFav =
          (profile?.favoriteDoctorIds ?? const []).contains(doctorId);
      emit(state.copyWith(favoritedIds: isFav ? {doctorId} : const {}));
    } catch (_) {
      // Keep optimistic/fallback state if fetch fails
    }
  }

  void setInitialFavorites(Iterable<String> ids) {
    if (state.favoritedIds.isNotEmpty) return;
    emit(state.copyWith(favoritedIds: {...ids}));
  }

  Future<void> toggleFavorite(String id) async {
    final wasFavorited = state.isFavorited(id);
    final newFavorited = !wasFavorited;

    // Optimistic UI update
    final newIds = {...state.favoritedIds};
    if (newFavorited) {
      newIds.add(id);
    } else {
      newIds.remove(id);
    }
    emit(state.copyWith(favoritedIds: newIds, clearError: true));

    try {
      final profile = await _userRepository.fetchCurrentUserProfile();
      if (profile == null) {
        throw Exception('User profile not found. Cannot update favorites.');
      }
      
      final profileIds = profile.favoriteDoctorIds.toSet();
      if (newFavorited) {
        profileIds.add(id);
      } else {
        profileIds.remove(id);
      }
      await _userRepository.updateUserProfile(
        profile.copyWith(favoriteDoctorIds: profileIds.toList()),
      );
    } on Exception catch (e) {
      // Revert on error
      final revertedIds = {...state.favoritedIds};
      if (wasFavorited) {
        revertedIds.add(id);
      } else {
        revertedIds.remove(id);
      }
      emit(state.copyWith(
        favoritedIds: revertedIds,
        hasError: true,
        errorMessage: mapError(e),
      ));
    }
  }
}
