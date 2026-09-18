import '../../../profile/data/models/role.dart';

/// Immutable state tracking the currently selected user role.
class ChooseRoleState {
  const ChooseRoleState({this.selectedRole = Role.patient});

  final Role selectedRole;

  ChooseRoleState copyWith({Role? selectedRole}) =>
      ChooseRoleState(selectedRole: selectedRole ?? this.selectedRole);

  @override
  bool operator ==(Object other) =>
      other is ChooseRoleState && other.selectedRole == selectedRole;

  @override
  int get hashCode => selectedRole.hashCode;
}
