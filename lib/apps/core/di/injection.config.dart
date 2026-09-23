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
import 'package:doctor_hunt/apps/features/common/auth/data/remote_data/auth_remote_data_source.dart'
    as _i607;
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repository_impl.dart'
    as _i871;
import 'package:doctor_hunt/apps/features/common/auth/domain/repositories/auth_repository.dart'
    as _i372;
import 'package:doctor_hunt/apps/features/common/auth/domain/usecases/auth_session_changes.dart'
    as _i263;
import 'package:doctor_hunt/apps/features/common/auth/domain/usecases/sign_in.dart'
    as _i928;
import 'package:doctor_hunt/apps/features/common/auth/domain/usecases/sign_in_with_google.dart'
    as _i158;
import 'package:doctor_hunt/apps/features/common/auth/domain/usecases/sign_out.dart'
    as _i426;
import 'package:doctor_hunt/apps/features/common/auth/domain/usecases/sign_up.dart'
    as _i1031;
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_cubit.dart'
    as _i831;
import 'package:doctor_hunt/apps/features/common/choose_role/presentation/controller/choose_role_cubit.dart'
    as _i1058;
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
    gh.lazySingleton<_i607.AuthRemoteDataSource>(
      () => _i607.AuthRemoteDataSource(auth: gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i372.AuthRepository>(
      () => _i871.AuthRepositoryImpl(
        gh<_i607.AuthRemoteDataSource>(),
        gh<_i974.UserService>(),
      ),
    );
    gh.lazySingleton<_i446.DoctorRepository>(
      () => _i828.DoctorRepositoryImpl(
        gh<_i607.AuthRemoteDataSource>(),
        gh<_i987.ManageDoctorService>(),
      ),
    );
    gh.lazySingleton<_i271.HomeDoctorRepository>(
      () => _i765.HomeDoctorRepositoryImpl(gh<_i708.HomeService>()),
    );
    gh.lazySingleton<_i263.AuthSessionChanges>(
      () => _i263.AuthSessionChanges(gh<_i372.AuthRepository>()),
    );
    gh.lazySingleton<_i928.SignIn>(
      () => _i928.SignIn(gh<_i372.AuthRepository>()),
    );
    gh.lazySingleton<_i158.SignInWithGoogle>(
      () => _i158.SignInWithGoogle(gh<_i372.AuthRepository>()),
    );
    gh.lazySingleton<_i426.SignOut>(
      () => _i426.SignOut(gh<_i372.AuthRepository>()),
    );
    gh.lazySingleton<_i1031.SignUp>(
      () => _i1031.SignUp(gh<_i372.AuthRepository>()),
    );
    gh.lazySingleton<_i247.UserRepository>(
      () => _i84.UserRepositoryImpl(
        gh<_i607.AuthRemoteDataSource>(),
        gh<_i974.UserService>(),
      ),
    );
    gh.factory<_i831.AuthCubit>(
      () => _i831.AuthCubit(
        gh<_i928.SignIn>(),
        gh<_i1031.SignUp>(),
        gh<_i158.SignInWithGoogle>(),
        gh<_i426.SignOut>(),
      ),
    );
    gh.factory<_i414.ManageDoctorsCubit>(
      () => _i414.ManageDoctorsCubit(gh<_i446.DoctorRepository>()),
    );
    gh.factory<_i591.UserCubit>(
      () => _i591.UserCubit(gh<_i247.UserRepository>()),
    );
    gh.factory<_i302.HomeCubit>(
      () => _i302.HomeCubit(gh<_i271.HomeDoctorRepository>()),
    );
    gh.lazySingleton<_i24.AuthRoleNotifier>(
      () => _i24.AuthRoleNotifier(
        gh<_i263.AuthSessionChanges>(),
        gh<_i247.UserRepository>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i391.FirebaseModule {}
