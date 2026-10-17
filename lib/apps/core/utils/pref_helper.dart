import 'package:shared_preferences/shared_preferences.dart';

/// Helper for accessing and persisting data in SharedPreferences.
class PrefHelper {
  const PrefHelper._();

  static const String _clinicLocationKey = 'central_clinic_location';
  static const String defaultClinicLocation =
      'Central Clinic, 123 Healthcare Ave';

  /// Saves the central clinic location to SharedPreferences.
  static Future<void> setClinicLocation(String location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_clinicLocationKey, location.trim());
  }

  /// Retrieves the central clinic location from SharedPreferences.
  /// Returns [defaultClinicLocation] if not set or empty.
  static Future<String> getClinicLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final location = prefs.getString(_clinicLocationKey);
    if (location != null && location.trim().isNotEmpty) {
      return location.trim();
    }
    return defaultClinicLocation;
  }
}

