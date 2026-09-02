enum AuthRequestStatus { idle, submitting, error, success }

class AuthState {
  const AuthState({this.status = AuthRequestStatus.idle, this.errorCode});

  final AuthRequestStatus status;
  final String? errorCode;

  AuthState copyWith({AuthRequestStatus? status, String? errorCode}) =>
      AuthState(status: status ?? this.status, errorCode: errorCode);

  @override
  bool operator ==(Object other) =>
      other is AuthState &&
      other.status == status &&
      other.errorCode == errorCode;

  @override
  int get hashCode => Object.hash(status, errorCode);
}
