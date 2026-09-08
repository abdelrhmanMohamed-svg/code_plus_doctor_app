import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../admin/data/repo/doctor_repository.dart';
import 'create_doctor_state.dart';

/// Manages the Create Doctor form submission state.
@injectable
class CreateDoctorCubit extends Cubit<CreateDoctorState> {
  CreateDoctorCubit(this._repository) : super(const CreateDoctorState());

  final DoctorRepository _repository;

  Future<void> submit({required String name, required String specialty}) async {
    emit(state.copyWith(status: CreateDoctorStatus.submitting));
    try {
      await _repository.createDoctor(name: name, specialty: specialty);
      emit(state.copyWith(status: CreateDoctorStatus.success));
    } on Exception {
      emit(state.copyWith(status: CreateDoctorStatus.failure));
    }
  }

  void reset() => emit(const CreateDoctorState());
}
