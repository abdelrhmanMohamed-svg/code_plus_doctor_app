// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:doctor_hunt/apps/core/auth/auth_role_notifier.dart' as _i24;
import 'package:doctor_hunt/apps/core/di/firebase_module.dart' as _i391;
import 'package:doctor_hunt/apps/features/admin/manage_doctors/data/repo/doctor_repository.dart'
    as _i446;
import 'package:doctor_hunt/apps/features/admin/manage_doctors/data/repo/doctor_repository_impl.dart'
    as _i828;
import 'package:doctor_hunt/apps/features/admin/manage_doctors/data/service/manage_doctor_service.dart'
    as _i987;
import 'package:doctor_hunt/apps/features/admin/manage_doctors/presentation/controller/manage_doctors_cubit.dart'
    as _i414;
import 'package:doctor_hunt/apps/features/common/choose_role/presentation/controller/choose_role_cubit.dart'
    as _i1058;
import 'package:doctor_hunt/apps/features/common/login/data/repo/auth_repository.dart'
    as _i957;
import 'package:doctor_hunt/apps/features/common/login/data/repo/auth_repository_impl.dart'
    as _i916;
import 'package:doctor_hunt/apps/features/common/login/data/service/auth_service.dart'
    as _i658;
import 'package:doctor_hunt/apps/features/common/login/presentation/controller/auth_cubit.dart'
    as _i519;
import 'package:doctor_hunt/apps/features/common/profile/data/repo/user_repository.dart'
    as _i247;
import 'package:doctor_hunt/apps/features/common/profile/data/repo/user_repository_impl.dart'
    as _i84;
import 'package:doctor_hunt/apps/features/common/profile/data/service/user_service.dart'
    as _i974;
import 'package:doctor_hunt/apps/features/common/profile/presentation/controller/user_cubit.dart'
    as _i591;
import 'package:doctor_hunt/apps/features/patient/doctor_details/presentation/controller/doctor_details_cubit.dart'
    as _i853;
import 'package:doctor_hunt/apps/features/patient/favourite_doctors/presentation/controller/favourite_doctors_cubit.dart'
    as _i167;
import 'package:doctor_hunt/apps/features/patient/find_doctors/presentation/controller/find_doctor_cubit.dart'
    as _i322;
import 'package:doctor_hunt/apps/features/patient/home/data/repo/home_doctor_repository.dart'
    as _i271;
import 'package:doctor_hunt/apps/features/patient/home/data/repo/home_doctor_repository_impl.dart'
    as _i765;
import 'package:doctor_hunt/apps/features/patient/home/data/service/home_services.dart'
    as _i708;
import 'package:doctor_hunt/apps/features/patient/home/presentation/controller/home_cubit.dart'
    as _i302;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.factory<_i1058.ChooseRoleCubit>(() => _i1058.ChooseRoleCubit());
    gh.factory<_i853.DoctorDetailsCubit>(() => _i853.DoctorDetailsCubit());
    gh.factory<_i167.FavouriteDoctorsCubit>(
      () => _i167.FavouriteDoctorsCubit(),
    );
    gh.factory<_i322.FindDoctorCubit>(() => _i322.FindDoctorCubit());
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.auth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i987.ManageDoctorService>(
      () => _i987.ManageDoctorService(firestore: gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i974.UserService>(
      () => _i974.UserService(firestore: gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i708.HomeService>(
      () => _i708.HomeService(firestore: gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i658.AuthService>(
      () => _i658.AuthService(auth: gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i957.AuthRepository>(
      () => _i916.AuthRepositoryImpl(
        gh<_i658.AuthService>(),
        gh<_i974.UserService>(),
      ),
    );
    gh.lazySingleton<_i247.UserRepository>(
      () => _i84.UserRepositoryImpl(
        gh<_i658.AuthService>(),
        gh<_i974.UserService>(),
      ),
    );
    gh.lazySingleton<_i271.HomeDoctorRepository>(
      () => _i765.HomeDoctorRepositoryImpl(gh<_i708.HomeService>()),
    );
    gh.factory<_i519.AuthCubit>(
      () => _i519.AuthCubit(gh<_i957.AuthRepository>()),
    );
    gh.lazySingleton<_i446.DoctorRepository>(
      () => _i828.DoctorRepositoryImpl(
        gh<_i658.AuthService>(),
        gh<_i987.ManageDoctorService>(),
      ),
    );
    gh.factory<_i414.ManageDoctorsCubit>(
      () => _i414.ManageDoctorsCubit(gh<_i446.DoctorRepository>()),
    );
    gh.factory<_i591.UserCubit>(
      () => _i591.UserCubit(gh<_i247.UserRepository>()),
    );
    gh.lazySingleton<_i24.AuthRoleNotifier>(
      () => _i24.AuthRoleNotifier(
        gh<_i957.AuthRepository>(),
        gh<_i247.UserRepository>(),
      ),
    );
    gh.factory<_i302.HomeCubit>(
      () => _i302.HomeCubit(gh<_i271.HomeDoctorRepository>()),
    );
    return this;
  }
}

class _$FirebaseModule extends _i391.FirebaseModule {}
