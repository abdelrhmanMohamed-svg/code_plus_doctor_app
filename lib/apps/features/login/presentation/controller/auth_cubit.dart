import 'package:doctor_hunt/apps/core/error/error_mapper.dart';
import 'package:doctor_hunt/apps/features/profile/data/models/role.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/repo/auth_repository.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(const AuthState());

  final AuthRepository _repository;

  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(status: AuthRequestStatus.submitting));
    try {
      await _repository.signIn(email: email, password: password);
      emit(state.copyWith(status: AuthRequestStatus.success));
    } on Exception catch (e) {
      emit(
        state.copyWith(status: AuthRequestStatus.error, errorCode: mapError(e)),
      );
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    Role? role,
  }) async {
    emit(state.copyWith(status: AuthRequestStatus.submitting));
    try {
      await _repository.signUp(
        name: name,
        email: email,
        password: password,
        role: role,
      );
      emit(state.copyWith(status: AuthRequestStatus.success));
    } on Exception catch (e) {
      emit(
        state.copyWith(status: AuthRequestStatus.error, errorCode: mapError(e)),
      );
    }
  }

  Future<void> signInWithGoogle({Role? role}) async {
    emit(state.copyWith(status: AuthRequestStatus.submitting));
    try {
      await _repository.signInWithGoogle(role: role);
      emit(state.copyWith(status: AuthRequestStatus.success));
    } on Exception catch (e) {
      emit(
        state.copyWith(status: AuthRequestStatus.error, errorCode: mapError(e)),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _repository.signOut();
      emit(state.copyWith(status: AuthRequestStatus.idle));
    } on Exception catch (e) {
      emit(
        state.copyWith(status: AuthRequestStatus.error, errorCode: mapError(e)),
      );
    }
  }
}
