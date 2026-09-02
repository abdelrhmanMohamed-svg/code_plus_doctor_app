String mapError(Exception e) {
  final message = e.toString();
  if (message.contains('invalid-credential')) return 'invalid-credential';
  if (message.contains('user-not-found')) return 'user-not-found';
  if (message.contains('wrong-password')) return 'wrong-password';
  if (message.contains('email-already-in-use')) return 'email-already-in-use';
  if (message.contains('weak-password')) return 'weak-password';
  if (message.contains('invalid-email')) return 'invalid-email';
  if (message.contains('network-request-failed')) {
    return 'network-request-failed';
  }
  if (message.contains('canceled') || message.contains('interrupted')) {
    return 'google-signin-canceled';
  }
  if (message.contains('clientConfigurationError') ||
      message.contains('providerConfigurationError') ||
      message.contains('uiUnavailable')) {
    return 'google-signin-config';
  }
  return 'generic';
}
