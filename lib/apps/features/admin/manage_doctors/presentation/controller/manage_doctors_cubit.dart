import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/error_mapper.dart';
import '../../data/repo/doctor_repository.dart';
import 'manage_doctors_state.dart';

@injectable
class ManageDoctorsCubit extends Cubit<ManageDoctorsState> {
  ManageDoctorsCubit(this._repository) : super(const ManageDoctorsState());

  final DoctorRepository _repository;

  static const _searchDebounceDelay = Duration(milliseconds: 300);

  final String _searchDebounceTag = _tag();

  int _lastRequestId = 0;

  static String _tag() =>
      'manage-doctors-search-${DateTime.now().toIso8601String()}';

  @override
  Future<void> close() {
    EasyDebounce.cancel(_searchDebounceTag);
    return super.close();
  }

  /// Reloads the list from the repository.
  /// Returns `true` when the reload completed successfully, `false` when it
  /// failed or was superseded by a newer request (search/filter change).
  Future<bool> loadDoctors({bool showLoading = true}) async {
    EasyDebounce.cancel(_searchDebounceTag);
    final requestId = ++_lastRequestId;
    emit(
      state.copyWith(
        hasError: false,
        errorMessage: null,
        isLoading: showLoading,
      ),
    );
    try {
      final doctors = await _repository.fetchMyDoctors(
        query: state.searchQuery,
        specialty: state.filterSpecialty,
      );
      if (requestId != _lastRequestId) return false;
      emit(state.copyWith(doctors: doctors, isLoading: false));
      return true;
    } on Exception catch (e) {
      if (requestId != _lastRequestId) return false;
      emit(
        state.copyWith(
          hasError: true,
          isLoading: false,
          errorMessage: mapError(e),
        ),
      );
      return false;
    }
  }

  void search(String query) {
    emit(state.copyWith(searchQuery: query));
    EasyDebounce.debounce(
      _searchDebounceTag,
      _searchDebounceDelay,
      () => loadDoctors(showLoading: false),
    );
  }

  void setSpecialtyFilter(String specialty) {
    emit(state.copyWith(filterSpecialty: specialty));
    loadDoctors(showLoading: false);
  }

  /// Deletes the doctor and removes it from the list.
  /// Returns true when the deletion succeeded.
  Future<bool> deleteDoctor(String id) async {
    try {
      await _repository.deleteDoctor(id);
      emit(
        state.copyWith(
          doctors: state.doctors.where((d) => d.id != id).toList(),
          errorMessage: null,
        ),
      );
      return true;
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: mapError(e)));
      return false;
    }
  }

  /// [id] is null when creating a new doctor and set when editing one.
  Future<void> submit({
    String? id,
    required String name,
    required String specialty,
  }) async {
    emit(
      state.copyWith(
        formStatus: DoctorFormStatus.submitting,
        errorMessage: null,
      ),
    );
    try {
      await _repository.saveDoctor(id: id, name: name, specialty: specialty);
      final reloaded = await loadDoctors(showLoading: false);
      emit(
        state.copyWith(
          formStatus: reloaded
              ? DoctorFormStatus.success
              : DoctorFormStatus.failure,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          formStatus: DoctorFormStatus.failure,
          errorMessage: mapError(e),
        ),
      );
    } finally {
      // The form screen is a transient consumer relying on this status;
      // always return it to `initial` so the shared list screen's error
      // snackbar is not silently suppressed afterwards.
      resetForm();
    }
  }

  void resetForm() =>
      emit(state.copyWith(formStatus: DoctorFormStatus.initial));
}
