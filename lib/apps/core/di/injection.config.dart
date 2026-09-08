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
import 'package:doctor_hunt/apps/features/admin/data/repo/doctor_repository.dart'
    as _i937;
import 'package:doctor_hunt/apps/features/admin/data/repo/doctor_repository_impl.dart'
    as _i197;
import 'package:doctor_hunt/apps/features/admin/data/service/doctor_service.dart'
    as _i358;
import 'package:doctor_hunt/apps/features/admin/presentation/controller/admin_cubit.dart'
    as _i492;
import 'package:doctor_hunt/apps/features/choose_role/presentation/controller/choose_role_cubit.dart'
    as _i100;
import 'package:doctor_hunt/apps/features/create_doctor/presentation/controller/create_doctor_cubit.dart'
    as _i829;
import 'package:doctor_hunt/apps/features/doctor_details/presentation/controller/doctor_details_cubit.dart'
    as _i769;
import 'package:doctor_hunt/apps/features/favourite_doctors/presentation/controller/favourite_doctors_cubit.dart'
    as _i750;
import 'package:doctor_hunt/apps/features/find_doctors/presentation/controller/find_doctor_cubit.dart'
    as _i50;
import 'package:doctor_hunt/apps/features/login/data/repo/auth_repository.dart'
    as _i498;
import 'package:doctor_hunt/apps/features/login/data/repo/auth_repository_impl.dart'
    as _i538;
import 'package:doctor_hunt/apps/features/login/data/service/auth_service.dart'
    as _i747;
import 'package:doctor_hunt/apps/features/login/presentation/controller/auth_cubit.dart'
    as _i45;
import 'package:doctor_hunt/apps/features/profile/data/repo/user_repository.dart'
    as _i766;
import 'package:doctor_hunt/apps/features/profile/data/repo/user_repository_impl.dart'
    as _i271;
import 'package:doctor_hunt/apps/features/profile/data/service/user_service.dart'
    as _i475;
import 'package:doctor_hunt/apps/features/profile/presentation/controller/user_cubit.dart'
    as _i464;
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
    gh.factory<_i100.ChooseRoleCubit>(() => _i100.ChooseRoleCubit());
    gh.factory<_i769.DoctorDetailsCubit>(() => _i769.DoctorDetailsCubit());
    gh.factory<_i750.FavouriteDoctorsCubit>(
      () => _i750.FavouriteDoctorsCubit(),
    );
    gh.factory<_i50.FindDoctorCubit>(() => _i50.FindDoctorCubit());
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.auth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i358.DoctorService>(
      () => _i358.DoctorService(firestore: gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i475.UserService>(
      () => _i475.UserService(firestore: gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i747.AuthService>(
      () => _i747.AuthService(auth: gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i766.UserRepository>(
      () => _i271.UserRepositoryImpl(
        gh<_i747.AuthService>(),
        gh<_i475.UserService>(),
      ),
    );
    gh.lazySingleton<_i498.AuthRepository>(
      () => _i538.AuthRepositoryImpl(
        gh<_i747.AuthService>(),
        gh<_i475.UserService>(),
      ),
    );
    gh.lazySingleton<_i937.DoctorRepository>(
      () => _i197.DoctorRepositoryImpl(
        gh<_i747.AuthService>(),
        gh<_i358.DoctorService>(),
      ),
    );
    gh.factory<_i45.AuthCubit>(
      () => _i45.AuthCubit(gh<_i498.AuthRepository>()),
    );
    gh.lazySingleton<_i24.AuthRoleNotifier>(
      () => _i24.AuthRoleNotifier(
        gh<_i498.AuthRepository>(),
        gh<_i766.UserRepository>(),
      ),
    );
    gh.factory<_i464.UserCubit>(
      () => _i464.UserCubit(gh<_i766.UserRepository>()),
    );
    gh.factory<_i492.AdminCubit>(
      () => _i492.AdminCubit(gh<_i937.DoctorRepository>()),
    );
    gh.factory<_i829.CreateDoctorCubit>(
      () => _i829.CreateDoctorCubit(gh<_i937.DoctorRepository>()),
    );
    return this;
  }
}

class _$FirebaseModule extends _i391.FirebaseModule {}
