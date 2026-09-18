/// Abstract create-doctor repository contract.
abstract class CreateDoctorRepository {
  /// Creates a doctor owned by the current admin.
  Future<void> createDoctor({required String name, required String specialty});
}
