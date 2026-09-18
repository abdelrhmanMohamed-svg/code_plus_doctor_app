import 'package:injectable/injectable.dart';

import '../../../../../core/models/doctor.dart';
import '../service/home_services.dart';
import 'home_doctor_repository.dart';

/// Concrete home doctor repository — reads active doctors via DoctorService.
@LazySingleton(as: HomeDoctorRepository)
class HomeDoctorRepositoryImpl implements HomeDoctorRepository {
  HomeDoctorRepositoryImpl(this._doctorService);

  final HomeService _doctorService;

  @override
  Future<List<Doctor>> fetchActiveDoctors() =>
      _doctorService.getActiveDoctors();
}
