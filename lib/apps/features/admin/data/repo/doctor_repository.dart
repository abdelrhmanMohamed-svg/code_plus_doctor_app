import '../../../../core/models/doctor.dart';

/// Abstract doctor repository contract.
abstract class DoctorRepository {
  /// Returns doctors created by the current admin, filtered by the given
  /// query (name/specialty) and specialty.
  Future<List<Doctor>> fetchMyDoctors({
    String query = '',
    String specialty = '',
  });

  /// Creates a doctor owned by the current admin.
  Future<void> createDoctor({
    required String name,
    required String specialty,
  });
}
