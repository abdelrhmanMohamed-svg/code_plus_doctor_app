import 'package:doctor_hunt/apps/core/error/error_mapper.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/role.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._signIn, this._signUp, this._signInWithGoogle, this._signOut)
    : super(const AuthState());

  final SignIn _signIn;
  final SignUp _signUp;
  final SignInWithGoogle _signInWithGoogle;
  final SignOut _signOut;

  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(status: AuthRequestStatus.submitting));
    try {
      await _signIn(email: email, password: password);
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
      await _signUp(name: name, email: email, password: password, role: role);
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
      await _signInWithGoogle(role: role);
      emit(state.copyWith(status: AuthRequestStatus.success));
    } on Exception catch (e) {
      emit(
        state.copyWith(status: AuthRequestStatus.error, errorCode: mapError(e)),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _signOut();
      emit(state.copyWith(status: AuthRequestStatus.idle));
    } on Exception catch (e) {
      emit(
        state.copyWith(status: AuthRequestStatus.error, errorCode: mapError(e)),
      );
    }
  }
}
