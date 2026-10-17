
enum AdminEditProfileStatus { initial, submitting, success, failure }

class AdminEditProfileState {
  const AdminEditProfileState({
    this.status = AdminEditProfileStatus.initial,
    this.errorMessage,
  });

  final AdminEditProfileStatus status;
  final String? errorMessage;

  AdminEditProfileState copyWith({
    AdminEditProfileStatus? status,
    String? errorMessage,
  }) {
    return AdminEditProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminEditProfileState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => status.hashCode ^ errorMessage.hashCode;
}
