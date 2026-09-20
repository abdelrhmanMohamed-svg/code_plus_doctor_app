import '../../../../../core/models/doctor.dart';

/// Abstract doctor repository contract.
abstract class DoctorRepository {
  /// Returns doctors created by the current admin, filtered by the given
  /// query (name/specialty) and specialty.
  Future<List<Doctor>> fetchMyDoctors({
    String query = '',
    String specialty = '',
  });

  /// Creates or updates a doctor owned by the current admin.
  /// When [id] is null a new doctor is created with a generated id;
  /// otherwise it updates only the form-edited fields of the doctor with
  /// that id, leaving any other document data untouched.
  Future<void> saveDoctor({
    String? id,
    required String name,
    required String specialty,
  });

  Future<void> deleteDoctor(String id);
}
