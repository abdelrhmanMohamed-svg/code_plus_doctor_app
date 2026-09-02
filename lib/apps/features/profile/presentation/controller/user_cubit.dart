import 'package:doctor_hunt/apps/features/profile/data/repo/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'user_state.dart';

/// Cubit that provides the current user's display name.
@injectable
class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepository) : super(const UserState()) {
    _loadUserName();
  }

  final UserRepository _userRepository;

  Future<void> _loadUserName() async {
    emit(state.copyWith(isLoading: true));
    try {
      final profile = await _userRepository.fetchCurrentUserProfile();
      emit(state.copyWith(name: profile?.name ?? '', isLoading: false));
    } catch (_) {
      emit(state.copyWith(name: '', isLoading: false));
    }
  }
}
