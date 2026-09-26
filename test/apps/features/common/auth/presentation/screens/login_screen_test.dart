import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_cubit.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_state.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/screens/login_screen.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/core/widgets/custom_text_field.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/auth_password_field.dart';
import 'package:doctor_hunt/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  late MockAuthCubit mockAuthCubit;

  setUpAll(() {
    LocaleSettings.setLocale(AppLocale.en);
  });

  setUp(() {
    mockAuthCubit = MockAuthCubit();
    when(() => mockAuthCubit.state).thenReturn(const AuthState());
  });

  Widget createWidgetUnderTest() {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider<AuthCubit>.value(
            value: mockAuthCubit,
            child: const LoginScreen(),
          ),
        ),
      ],
    );

    return TranslationProvider(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) => MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );
  }

  group('LoginScreen Widget Tests', () {
    testWidgets('renders email, password fields and login button', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(CustomTextField), findsOneWidget);
      expect(find.byType(AuthPasswordField), findsOneWidget);
      expect(find.byType(PrimaryButton), findsOneWidget);
    });

    testWidgets('shows validation errors when fields are empty', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(PrimaryButton));
      await tester.pumpAndSettle();

      // Both email and password fields will show the required field error
      expect(find.text(t.auth.fieldRequired), findsNWidgets(2));
      verifyNever(() => mockAuthCubit.signIn(email: any(named: 'email'), password: any(named: 'password')));
    });

    testWidgets('calls signIn on Cubit when fields are valid and button is tapped', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      when(() => mockAuthCubit.signIn(email: 'test@test.com', password: 'password'))
          .thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Enter valid email and password
      await tester.enterText(find.byType(CustomTextField), 'test@test.com');
      await tester.enterText(find.byType(AuthPasswordField), 'password');
      await tester.pumpAndSettle();

      // Tap Sign In button
      await tester.tap(find.byType(PrimaryButton));
      await tester.pumpAndSettle();

      verify(() => mockAuthCubit.signIn(email: 'test@test.com', password: 'password')).called(1);
    });

    testWidgets('shows loading indicator when state is submitting', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      whenListen(
        mockAuthCubit,
        Stream.fromIterable([
          const AuthState(status: AuthRequestStatus.submitting),
        ]),
        initialState: const AuthState(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(milliseconds: 100));

      final primaryButton = tester.widget<PrimaryButton>(find.byType(PrimaryButton));
      expect(primaryButton.isLoading, isTrue);
    });
  });
}
