import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';

/// Maps raw error codes to user-facing translated messages.
///
/// Usage:
/// ```dart
/// context.showErrorSnackBar(context.resolveAuthCode('user-not-found'));
/// ```
extension ErrorMapper on BuildContext {
  String resolveAuthCode(String code) {
    final t = this.t;
    if (code == 'invalid-credential') return t.auth.invalidCredentials;
    if (code == 'user-not-found') return t.auth.userNotFound;
    if (code == 'wrong-password') return t.auth.wrongPassword;
    if (code == 'email-already-in-use') return t.auth.emailAlreadyInUse;
    if (code == 'weak-password') return t.auth.weakPassword;
    if (code == 'invalid-email') return t.auth.invalidEmail;
    if (code == 'network-request-failed') return t.auth.networkRequestFailed;
    if (code == 'google-signin-config') return t.auth.googleSignInConfig;
    if (code == 'google-signin-error') return t.auth.googleSignInError;
    if (code == 'google-signin-canceled') return '';
    return t.auth.generic;
  }
}
