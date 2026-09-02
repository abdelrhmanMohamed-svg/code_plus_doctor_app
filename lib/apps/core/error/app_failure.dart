/// Base failure for application errors surfaced to the UI.
class AppFailure implements Exception {
  const AppFailure({this.code, this.message, this.cause});

  final String? code;
  final String? message;
  final Object? cause;

  @override
  String toString() => 'AppFailure($code: $message)';
}
