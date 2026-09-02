import 'package:doctor_hunt/apps/features/favourite_doctors/presentation/screens/favourite_doctors_screen.dart';
import 'package:go_router/go_router.dart';

import '../auth/auth_status_notifier.dart';
import '../di/injection.dart';
import '../widgets/app_shell.dart';
import '../widgets/loading_screen.dart';
import '../../features/appointment_booking/presentation/screens/appointment_booking_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/choose_role/presentation/screens/choose_role_screen.dart';
import '../../features/doctor_details/presentation/screens/doctor_details_screen.dart';
import '../../features/find_doctors/presentation/screens/find_doctors_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/login/presentation/screens/login_screen.dart';
import '../../features/login/presentation/screens/sign_up_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

/// Centralized route configuration. No direct `Navigator` in feature code.
class AppRouter {
  AppRouter._();

  static const String onboarding = '/onboarding';
  static const String splash = '/splash';
  static const String chooseRole = '/choose-role';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String home = '/home';
  static const String findDoctors = '/find-doctors';
  static const String doctorDetails = '/doctor-details';
  static const String favourites = '/favourites';
  static const String appointmentBooking = '/appointment-booking';
  static const String chat = '/chat';
  static const String profile = '/profile';

  static const _authRoutes = {onboarding, chooseRole, login, signUp};
  static const _shellRoutes = {home, favourites, chat, profile};

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    refreshListenable: getIt<AuthStatusNotifier>(),
    redirect: (context, state) {
      final status = getIt<AuthStatusNotifier>().value;
      final path = state.matchedLocation;

      if (status == AuthSessionStatus.unknown) return splash;

      if (status == AuthSessionStatus.authenticated) {
        if (path == splash || _authRoutes.contains(path)) return home;
      }

      if (status == AuthSessionStatus.unauthenticated) {
        if (path == splash || _shellRoutes.contains(path)) {
          return onboarding;
        }
      }

      return null;
    },
    routes: [
      GoRoute(path: splash, builder: (context, state) => const LoadingScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: chooseRole,
        builder: (context, state) => const ChooseRoleScreen(),
      ),
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: signUp, builder: (context, state) => const SignUpScreen()),
      GoRoute(
        path: findDoctors,
        builder: (context, state) => const FindDoctorsScreen(),
      ),
      GoRoute(
        path: doctorDetails,
        builder: (context, state) => const DoctorDetailsScreen(),
      ),
      GoRoute(
        path: appointmentBooking,
        builder: (context, state) => const AppointmentBookingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: favourites,
                builder: (context, state) => const FavouriteDoctorsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: chat,
                builder: (context, state) => const ChatScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
