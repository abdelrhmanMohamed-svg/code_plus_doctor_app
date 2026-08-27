// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:doctor_hunt/apps/features/choose_role/presentation/controller/choose_role_cubit.dart'
    as _i100;
import 'package:doctor_hunt/apps/features/doctor_details/presentation/controller/doctor_details_cubit.dart'
    as _i769;
import 'package:doctor_hunt/apps/features/favourite_doctors/presentation/controller/favourite_doctors_cubit.dart'
    as _i750;
import 'package:doctor_hunt/apps/features/find_doctors/presentation/controller/find_doctor_cubit.dart'
    as _i50;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i100.ChooseRoleCubit>(() => _i100.ChooseRoleCubit());
    gh.factory<_i769.DoctorDetailsCubit>(() => _i769.DoctorDetailsCubit());
    gh.factory<_i750.FavouriteDoctorsCubit>(
      () => _i750.FavouriteDoctorsCubit(),
    );
    gh.factory<_i50.FindDoctorCubit>(() => _i50.FindDoctorCubit());
    return this;
  }
}
