import 'package:doctor_hunt/apps/core/error/auth_failure.dart';
import 'package:doctor_hunt/apps/core/models/doctor.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/remote_data/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../service/manage_doctor_service.dart';
import 'doctor_repository.dart';

/// Concrete doctor repository — persists doctors to Firestore via DoctorService.
@LazySingleton(as: DoctorRepository)
class DoctorRepositoryImpl implements DoctorRepository {
  DoctorRepositoryImpl(this._remoteDataSource, this._doctorService);

  final AuthRemoteDataSource _remoteDataSource;
  final ManageDoctorService _doctorService;

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
  Future<void> saveDoctor({
    String? id,
    required String name,
    required String specialty,
  }) async {
    if (id == null) {
      final newDoctor = Doctor(
        id: _doctorService.newDoctorId(),
        name: name,
        specialty: specialty,
        adminId: _currentAdminId(),
      );
      await _doctorService.createDoctor(newDoctor);
      return;
    }
    await _doctorService.updateDoctor(id: id, name: name, specialty: specialty);
  }

  @override
  Future<void> deleteDoctor(String id) => _doctorService.deleteDoctor(id);

  String _currentAdminId() {
    final user = _remoteDataSource.currentUser;
    if (user == null) throw const AuthFailure(code: 'missing-user');
    return user.uid;
  }
}
