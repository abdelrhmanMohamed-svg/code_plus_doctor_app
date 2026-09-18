import '../../../../../core/models/doctor.dart';

/// Abstract doctor repository contract for the patient home screen.
abstract class HomeDoctorRepository {
  /// Returns all active doctors available to patients.
  Future<List<Doctor>> fetchActiveDoctors();
}
