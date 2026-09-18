import 'package:doctor_hunt/apps/core/error/auth_failure.dart';
import 'package:doctor_hunt/apps/core/models/doctor.dart';
import 'package:doctor_hunt/apps/features/common/login/data/service/auth_service.dart';
import 'package:injectable/injectable.dart';

import '../service/create_doctor_service.dart';
import 'create_doctor_repository.dart';

/// Concrete create-doctor repository — persists doctors to Firestore via CreateDoctorService.
@LazySingleton(as: CreateDoctorRepository)
class CreateDoctorRepositoryImpl implements CreateDoctorRepository {
  CreateDoctorRepositoryImpl(this._authService, this._createDoctorService);

  final AuthService _authService;
  final CreateDoctorService _createDoctorService;

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
    await _createDoctorService.addDoctor(doctor);
  }

  String _currentAdminId() {
    final user = _authService.currentUser;
    if (user == null) throw const AuthFailure(code: 'missing-user');
    return user.uid;
  }
}
