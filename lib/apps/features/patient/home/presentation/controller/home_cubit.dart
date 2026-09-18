import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/error_mapper.dart';
import '../../data/repo/home_doctor_repository.dart';
import 'home_state.dart';

/// Loads the active doctors shown on the patient home screen.
@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeState());

  final HomeDoctorRepository _repository;

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
      emit(state.copyWith(doctors: doctors, isLoading: false));
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
