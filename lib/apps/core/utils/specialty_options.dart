import '../../../i18n/strings.g.dart';

/// Specialty options for dropdowns/filters, from the centralized translations.
List<String> specialtyOptions(Translations t) {
  final specialties = t.specialties;
  return [
    specialties.cardiologist,
    specialties.orthopedic,
    specialties.dermatologist,
    specialties.pediatrician,
    specialties.neurologist,
    specialties.ophthalmologist,
    specialties.general,
  ];
}
