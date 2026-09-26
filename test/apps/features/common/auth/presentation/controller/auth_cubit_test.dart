import 'package:bloc_test/bloc_test.dart';
import 'package:doctor_hunt/apps/core/error/auth_failure.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/usecases/sign_in.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/usecases/sign_in_with_google.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/usecases/sign_out.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/usecases/sign_up.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_cubit.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignIn extends Mock implements SignIn {}
class MockSignUp extends Mock implements SignUp {}
class MockSignInWithGoogle extends Mock implements SignInWithGoogle {}
class MockSignOut extends Mock implements SignOut {}

void main() {
  late MockSignIn mockSignIn;
  late MockSignUp mockSignUp;
  late MockSignInWithGoogle mockSignInWithGoogle;
  late MockSignOut mockSignOut;
  late AuthCubit authCubit;

  setUp(() {
    mockSignIn = MockSignIn();
    mockSignUp = MockSignUp();
    mockSignInWithGoogle = MockSignInWithGoogle();
    mockSignOut = MockSignOut();
    authCubit = AuthCubit(
      mockSignIn,
      mockSignUp,
      mockSignInWithGoogle,
      mockSignOut,
    );
  });

  tearDown(() {
    authCubit.close();
  });

  group('AuthCubit', () {
    test('initial state is AuthState()', () {
      expect(authCubit.state, const AuthState());
    });

    blocTest<AuthCubit, AuthState>(
      'emits [submitting, success] when signIn succeeds',
      build: () {
        when(() => mockSignIn(email: 'test@test.com', password: 'password'))
            .thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) => cubit.signIn(email: 'test@test.com', password: 'password'),
      expect: () => [
        const AuthState(status: AuthRequestStatus.submitting),
        const AuthState(status: AuthRequestStatus.success),
      ],
      verify: (_) {
        verify(() => mockSignIn(email: 'test@test.com', password: 'password'))
            .called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [submitting, error] when signIn throws',
      build: () {
        when(() => mockSignIn(email: 'test@test.com', password: 'password'))
            .thenThrow(AuthFailure(code: 'user-not-found'));
        return authCubit;
      },
      act: (cubit) => cubit.signIn(email: 'test@test.com', password: 'password'),
      expect: () => [
        const AuthState(status: AuthRequestStatus.submitting),
        const AuthState(status: AuthRequestStatus.error, errorCode: 'user-not-found'),
      ],
      verify: (_) {
        verify(() => mockSignIn(email: 'test@test.com', password: 'password'))
            .called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [submitting, success] when signUp succeeds',
      build: () {
        when(() => mockSignUp(
              name: 'John',
              email: 'test@test.com',
              password: 'password',
              role: null,
            )).thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) => cubit.signUp(
        name: 'John',
        email: 'test@test.com',
        password: 'password',
      ),
      expect: () => [
        const AuthState(status: AuthRequestStatus.submitting),
        const AuthState(status: AuthRequestStatus.success),
      ],
      verify: (_) {
        verify(() => mockSignUp(
              name: 'John',
              email: 'test@test.com',
              password: 'password',
              role: null,
            )).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [submitting, success] when signInWithGoogle succeeds',
      build: () {
        when(() => mockSignInWithGoogle(role: null)).thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => [
        const AuthState(status: AuthRequestStatus.submitting),
        const AuthState(status: AuthRequestStatus.success),
      ],
      verify: (_) {
        verify(() => mockSignInWithGoogle(role: null)).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [idle] when signOut succeeds',
      build: () {
        when(() => mockSignOut()).thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) => cubit.signOut(),
      expect: () => [
        const AuthState(status: AuthRequestStatus.idle),
      ],
      verify: (_) {
        verify(() => mockSignOut()).called(1);
      },
    );
  });
}
