import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'apps/core/di/injection.dart';
import 'apps/core/theme/app_colors.dart';
import 'apps/core/router/app_router.dart';
import 'apps/features/login/presentation/controller/auth_cubit.dart';
import 'i18n/strings.g.dart';

/// Root application widget.
class DoctorHuntApp extends StatelessWidget {
  const DoctorHuntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [BlocProvider(create: (_) => getIt<AuthCubit>())],
        child: MaterialApp.router(
          title: context.t.common.brandName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green),
          ),
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
