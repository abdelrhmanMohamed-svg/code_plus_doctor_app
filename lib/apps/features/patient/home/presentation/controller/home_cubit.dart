import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/error_mapper.dart';
import '../../../../common/profile/data/repo/user_repository.dart';
import '../../data/repo/home_doctor_repository.dart';
import 'home_state.dart';

/// Loads the active doctors shown on the patient home screen.
@injectable
class HomeCubit extends Cubit<HomeState> {
  StreamSubscription? _profileSubscription;

  HomeCubit(this._repository, this._userRepository) : super(const HomeState()) {
    _profileSubscription = _userRepository.profileStream.listen((profile) {
      if (profile != null && !state.isLoading && state.doctors.isNotEmpty) {
        final favIds = profile.favoriteDoctorIds.toSet();
        final mappedDoctors = state.doctors
            .map((doc) => doc.copyWith(isFavorited: favIds.contains(doc.id)))
            .toList();
        emit(state.copyWith(doctors: mappedDoctors));
      }
    });
  }

  final HomeDoctorRepository _repository;
  final UserRepository _userRepository;

  @override
  Future<void> close() {
    _profileSubscription?.cancel();
    return super.close();
  }

  Future<void> loadDoctors({bool showLoading = true}) async {
    emit(
      state.copyWith(
        isLoading: showLoading,
        hasError: false,
        errorMessage: null,
      ),
    );
    try {
      final doctors = await _repository.fetchActiveDoctors();
      final profile = await _userRepository.fetchCurrentUserProfile();
      final favIds = (profile?.favoriteDoctorIds ?? const []).toSet();
      final mappedDoctors = doctors
          .map((doc) => doc.copyWith(isFavorited: favIds.contains(doc.id)))
          .toList();

      emit(state.copyWith(doctors: mappedDoctors, isLoading: false));
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

  Future<void> refresh() => loadDoctors(showLoading: false);
}
