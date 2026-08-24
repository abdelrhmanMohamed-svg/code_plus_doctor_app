import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'choose_role_state.dart';

/// Tracks the role selected on the choose-role screen.
@injectable
class ChooseRoleCubit extends Cubit<ChooseRoleState> {
  ChooseRoleCubit() : super(const ChooseRoleState());

  void selectRole(Role role) {
    if (state.selectedRole == role) return;
    emit(state.copyWith(selectedRole: role));
  }
}
