/// Submission status for the Create Doctor form.
enum CreateDoctorStatus { initial, submitting, success, failure }

/// Immutable state for the Create Doctor screen.
class CreateDoctorState {
  const CreateDoctorState({this.status = CreateDoctorStatus.initial});

  final CreateDoctorStatus status;

  CreateDoctorState copyWith({CreateDoctorStatus? status}) =>
      CreateDoctorState(status: status ?? this.status);

  @override
  bool operator ==(Object other) =>
      other is CreateDoctorState && other.status == status;

  @override
  int get hashCode => status.hashCode;
}
