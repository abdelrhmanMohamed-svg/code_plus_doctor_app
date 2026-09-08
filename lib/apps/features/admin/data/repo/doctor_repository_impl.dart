import 'package:doctor_hunt/apps/core/error/auth_failure.dart';
import 'package:doctor_hunt/apps/core/models/doctor.dart';
import 'package:doctor_hunt/apps/features/login/data/service/auth_service.dart';
import 'package:injectable/injectable.dart';

import '../service/doctor_service.dart';
import 'doctor_repository.dart';

/// Concrete doctor repository — persists doctors to Firestore via DoctorService.
@LazySingleton(as: DoctorRepository)
class DoctorRepositoryImpl implements DoctorRepository {
  DoctorRepositoryImpl(this._authService, this._doctorService);

  final AuthService _authService;
  final DoctorService _doctorService;

  @override
  Future<List<Doctor>> fetchMyDoctors({
    String query = '',
    String specialty = '',
  }) async {
    final doctors = await _doctorService.getDoctorsByAdmin(_currentAdminId());
    final normalizedQuery = query.toLowerCase();
    return doctors.where((doctor) {
      final bool matchesSpecialty =
          specialty.isEmpty || doctor.specialty == specialty;
      if (!matchesSpecialty) return false;
      if (normalizedQuery.isEmpty) return true;
      return doctor.name.toLowerCase().contains(normalizedQuery) ||
          doctor.specialty.toLowerCase().contains(normalizedQuery);
    }).toList();
  }

  @override
  Future<void> createDoctor({
    required String name,
    required String specialty,
  }) async {
    final adminId = _currentAdminId();
    final doctor = Doctor(
      id: '',
      name: name,
      specialty: specialty,
      adminId: adminId,
    );
    await _doctorService.addDoctor(doctor);
  }

  String _currentAdminId() {
    final user = _authService.currentUser;
    if (user == null) throw const AuthFailure(code: 'missing-user');
    return user.uid;
  }
}
