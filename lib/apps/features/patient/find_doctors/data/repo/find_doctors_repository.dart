import '../../../../../core/models/doctor.dart';

/// Abstract doctor repository contract for the find doctors screen.
abstract class FindDoctorsRepository {
  /// Returns all active doctors available to search.
  Future<List<Doctor>> fetchDoctors();
}
