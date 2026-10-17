import 'package:doctor_hunt/apps/core/error/auth_failure.dart';
import 'package:doctor_hunt/apps/core/models/doctor.dart';
import 'package:doctor_hunt/apps/core/utils/app_constants.dart';
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
    final doctors = await _doctorService.getDoctorsByAdmin(_currentAdminId(), specialty: specialty);
    final normalizedQuery = query.toLowerCase();
    return doctors.where((doctor) {
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
    required String price,
    required bool isActive,
    String? photoUrl,
  }) async {
    if (id == null) {
      final newDoctor = Doctor(
        id: _doctorService.newDoctorId(),
        name: name,
        specialty: specialty,
        price: price,
        isActive: isActive,
        photo: photoUrl ?? AppConstants.doctorDefaultPhoto,
        adminId: _currentAdminId(),
      );
      await _doctorService.createDoctor(newDoctor);
      return;
    }
    await _doctorService.updateDoctor(
      id: id,
      name: name,
      specialty: specialty,
      price: price,
      isActive: isActive,
      photoUrl: photoUrl,
    );
  }

  @override
  Future<void> saveDoctorAvailability({
    required String id,
    required List<String> workingDays,
    required String startTime,
    required String endTime,
    required int slotDuration,
  }) async {
    await _doctorService.updateDoctorAvailability(
      id: id,
      workingDays: workingDays,
      startTime: startTime,
      endTime: endTime,
      slotDuration: slotDuration,
    );
  }

  @override
  Future<void> deleteDoctor(String id) => _doctorService.deleteDoctor(id);

  String _currentAdminId() {
    final user = _remoteDataSource.currentUser;
    if (user == null) throw const AuthFailure(code: 'missing-user');
    return user.uid;
  }
}
