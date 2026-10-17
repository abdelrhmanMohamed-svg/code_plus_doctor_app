
enum PatientEditProfileStatus { initial, submitting, success, failure }

class PatientEditProfileState {
  const PatientEditProfileState({
    this.status = PatientEditProfileStatus.initial,
    this.errorMessage,
  });

  final PatientEditProfileStatus status;
  final String? errorMessage;

  PatientEditProfileState copyWith({
    PatientEditProfileStatus? status,
    String? errorMessage,
  }) {
    return PatientEditProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientEditProfileState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => status.hashCode ^ errorMessage.hashCode;
}
