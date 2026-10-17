import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/user_profile.dart';
import '../../data/repo/user_repository.dart';

import 'user_state.dart';

/// Cubit that provides the current user's profile.
@lazySingleton
class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepository) : super(const UserState()) {
    _loadUserProfile();
  }

  final UserRepository _userRepository;

  Future<void> _loadUserProfile() async {
    emit(state.copyWith(isLoading: true));
    try {
      final profile = await _userRepository.fetchCurrentUserProfile();
      emit(state.copyWith(profile: profile, isLoading: false));
    } catch (_) {
      emit(state.copyWith(profile: null, isLoading: false));
    }
  }

  Future<void> updateProfile(UserProfile profile) async {
    try {
      await _userRepository.updateUserProfile(profile);
      emit(state.copyWith(profile: profile));
    } catch (_) {
      // In a real app we might want to emit an error state here,
      // but the specific form cubit will handle the success/failure state
    }
  }
}
