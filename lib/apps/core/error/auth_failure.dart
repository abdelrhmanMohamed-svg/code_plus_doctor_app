import 'app_failure.dart';

/// Auth-specific failure.
class AuthFailure extends AppFailure {
  const AuthFailure({String? code, String? message, Object? cause})
    : super(code: code, message: message, cause: cause);

  @override
  String toString() => 'AuthFailure($code: $message)';
}
