/// The two app user roles selectable on the choose-role screen.
enum Role { patient, doctor }

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
