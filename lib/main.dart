import 'package:flutter/material.dart';

import 'app.dart';
import 'apps/core/di/injection.dart';
import 'i18n/strings.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(TranslationProvider(child: const DoctorHuntApp()));
}
