import 'app_failure.dart';

/// Auth-specific failure.
class AuthFailure extends AppFailure {
  const AuthFailure({super.code, super.message, super.cause});

  @override
  String toString() => 'AuthFailure($code: $message)';
}
