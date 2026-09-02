import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';

class AppValidator {
  const AppValidator._();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static const int _minPasswordLength = 6;

  static FormFieldValidator<String> required(Translations t) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return t.auth.fieldRequired;
      }
      return null;
    };
  }

  static FormFieldValidator<String> email(Translations t) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return t.auth.fieldRequired;
      }
      if (!_emailRegex.hasMatch(value.trim())) {
        return t.auth.invalidEmail;
      }
      return null;
    };
  }

  static FormFieldValidator<String> password(Translations t) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return t.auth.fieldRequired;
      }
      if (value.length < _minPasswordLength) {
        return t.auth.passwordTooShort;
      }
      return null;
    };
  }

  static FormFieldValidator<String> confirmPassword(
    Translations t,
    TextEditingController other,
  ) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return t.auth.fieldRequired;
      }
      if (value != other.text) {
        return t.auth.passwordsMismatch;
      }
      return null;
    };
  }
}
