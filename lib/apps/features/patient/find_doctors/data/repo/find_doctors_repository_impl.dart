import 'package:injectable/injectable.dart';

import '../../../../../core/models/doctor.dart';
import '../service/find_doctors_service.dart';
import 'find_doctors_repository.dart';

/// Concrete find doctors repository — reads active doctors via FindDoctorsService.
@LazySingleton(as: FindDoctorsRepository)
class FindDoctorsRepositoryImpl implements FindDoctorsRepository {
  FindDoctorsRepositoryImpl(this._service);

  final FindDoctorsService _service;

  @override
  Future<List<Doctor>> fetchDoctors() => _service.getActiveDoctors();
}
