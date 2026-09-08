import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error_mapper.dart';
import '../../data/repo/doctor_repository.dart';
import 'admin_state.dart';

@injectable
class AdminCubit extends Cubit<AdminState> {
  AdminCubit(this._repository) : super(const AdminState());

  final DoctorRepository _repository;

  static const _searchDebounceDelay = Duration(milliseconds: 300);

  final String _searchDebounceTag = _tag();

  static String _tag() => 'admin-search-${DateTime.now().toIso8601String()}';

  @override
  Future<void> close() {
    EasyDebounce.cancel(_searchDebounceTag);
    return super.close();
  }

  Future<void> loadDoctors({bool showLoading = true}) async {
    EasyDebounce.cancel(_searchDebounceTag);
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
      emit(state.copyWith(doctors: doctors, isLoading: false));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          hasError: true,
          isLoading: false,
          errorMessage: mapError(e),
        ),
      );
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
}
