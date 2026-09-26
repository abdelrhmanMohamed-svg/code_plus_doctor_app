import 'package:doctor_hunt/apps/features/common/auth/data/remote_data/auth_remote_data_source.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repository_impl.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/role.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/user_profile.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}
class MockUserService extends Mock implements UserService {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}
class FakeUserProfile extends Fake implements UserProfile {}

void main() {
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockUserService mockUserService;
  late AuthRepositoryImpl repository;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  setUpAll(() {
    registerFallbackValue(FakeUserProfile());
  });

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockUserService = MockUserService();
    repository = AuthRepositoryImpl(mockRemoteDataSource, mockUserService);
    
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
  });

  group('AuthRepositoryImpl', () {
    test('signIn calls remoteDataSource.signInWithEmail', () async {
      when(() => mockRemoteDataSource.signInWithEmail(
            email: 'test@test.com',
            password: 'password',
          )).thenAnswer((_) async => mockUserCredential);

      await repository.signIn(email: 'test@test.com', password: 'password');

      verify(() => mockRemoteDataSource.signInWithEmail(
            email: 'test@test.com',
            password: 'password',
          )).called(1);
    });

    test('signUp creates user profile on success', () async {
      when(() => mockRemoteDataSource.signUpWithEmail(
            email: 'test@test.com',
            password: 'password',
          )).thenAnswer((_) async => mockUserCredential);
      
      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('user123');
      when(() => mockUser.updateDisplayName(any())).thenAnswer((_) async {});
      when(() => mockUserService.createUserProfile(any()))
          .thenAnswer((_) async {});

      await repository.signUp(
        name: 'John',
        email: 'test@test.com',
        password: 'password',
        role: Role.patient,
      );

      verify(() => mockRemoteDataSource.signUpWithEmail(
            email: 'test@test.com',
            password: 'password',
          )).called(1);
      verify(() => mockUser.updateDisplayName('John')).called(1);
      verify(() => mockUserService.createUserProfile(any())).called(1);
    });

    test('signUp throws StateError if user is null', () async {
      when(() => mockRemoteDataSource.signUpWithEmail(
            email: 'test@test.com',
            password: 'password',
          )).thenAnswer((_) async => mockUserCredential);
      
      when(() => mockUserCredential.user).thenReturn(null);

      expect(
        () => repository.signUp(
          name: 'John',
          email: 'test@test.com',
          password: 'password',
        ),
        throwsA(isA<StateError>()),
      );
    });

    test('signInWithGoogle creates profile if not exists', () async {
      when(() => mockRemoteDataSource.signInWithGoogle())
          .thenAnswer((_) async => mockUserCredential);
      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('user123');
      when(() => mockUser.displayName).thenReturn('Google User');
      when(() => mockUser.email).thenReturn('google@test.com');
      
      when(() => mockUserService.getUserProfile('user123'))
          .thenAnswer((_) async => null); // Profile doesn't exist
      when(() => mockUserService.createUserProfile(any()))
          .thenAnswer((_) async {});

      await repository.signInWithGoogle(role: Role.admin);

      verify(() => mockUserService.getUserProfile('user123')).called(1);
      verify(() => mockUserService.createUserProfile(any())).called(1);
    });

    test('signInWithGoogle does not create profile if exists', () async {
      when(() => mockRemoteDataSource.signInWithGoogle())
          .thenAnswer((_) async => mockUserCredential);
      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('user123');
      
      when(() => mockUserService.getUserProfile('user123'))
          .thenAnswer((_) async => FakeUserProfile()); // Profile exists

      await repository.signInWithGoogle();

      verify(() => mockUserService.getUserProfile('user123')).called(1);
      verifyNever(() => mockUserService.createUserProfile(any()));
    });

    test('signOut calls remoteDataSource.signOut', () async {
      when(() => mockRemoteDataSource.signOut()).thenAnswer((_) async {});

      await repository.signOut();

      verify(() => mockRemoteDataSource.signOut()).called(1);
    });
  });
}
