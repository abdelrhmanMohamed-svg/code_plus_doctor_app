import 'package:doctor_hunt/apps/features/common/profile/presentation/controller/user_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/presentation/screens/patient_appointments_screen.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/presentation/screens/patient_appointment_details_screen.dart';
import 'package:doctor_hunt/apps/features/patient/favourite_doctors/presentation/screens/favourite_doctors_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/appointments/presentation/screens/admin_appointment_details_screen.dart';
import '../../features/admin/appointments/presentation/screens/admin_appointments_screen.dart';
import '../../features/admin/appointments/presentation/controller/admin_appointments_cubit.dart';
import '../../features/admin/manage_doctors/presentation/controller/manage_doctors_cubit.dart';
import '../../features/admin/manage_doctors/presentation/screens/doctor_form_screen.dart';
import '../../features/admin/manage_doctors/presentation/screens/manage_doctors_screen.dart';
import '../../features/admin/settings/presentation/screens/admin_edit_profile_screen.dart';
import '../../features/admin/settings/presentation/screens/admin_settings_screen.dart';
import '../../features/admin/shell/presentation/widgets/admin_shell.dart';
import '../../features/admin/manage_doctors/presentation/screens/admin_doctor_details_screen.dart';
import '../../features/admin/manage_doctors/presentation/screens/admin_doctor_availability_screen.dart';
import '../../features/patient/appointment_booking/presentation/screens/appointment_booking_screen.dart';
import '../../features/common/choose_role/presentation/screens/choose_role_screen.dart';
import '../../features/patient/doctor_details/presentation/screens/doctor_details_screen.dart';
import '../../features/patient/find_doctors/presentation/screens/find_doctors_screen.dart';
import '../../features/patient/home/presentation/screens/home_screen.dart';
import '../../features/patient/home/presentation/screens/section_doctors_screen.dart';
import '../../features/common/auth/presentation/screens/login_screen.dart';
import '../../features/common/auth/presentation/screens/sign_up_screen.dart';
import '../../features/common/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/common/profile/data/models/role.dart';
import '../../features/patient/profile/presentation/screens/patient_settings_screen.dart';
import '../../features/patient/profile/presentation/screens/patient_edit_profile_screen.dart';
import '../../features/patient/profile/presentation/screens/privacy_policy_screen.dart';
import '../auth/auth_role_notifier.dart';
import '../di/injection.dart';
import '../models/appointment.dart';
import '../models/doctor.dart';
import '../widgets/app_shell.dart';
import '../widgets/loading_screen.dart';

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
  static const String patientAppointments = '/patient-appointments';
  static const String patientAppointmentDetails = '/patient-appointment-details';
  static const String profile = '/profile';
  static const String createDoctor = '/create-doctor';
  static const String editDoctor = '/edit-doctor';
  static const String admin = '/admin';
  static const String adminAppointments = '/admin-appointments';
  static const String adminSettings = '/admin-settings';
  static const String adminDoctorDetails = '/admin-doctor-details';
  static const String adminDoctorAvailability = '/admin-doctor-availability';
  static const String adminAppointmentDetails = '/admin-appointment-details';
  static const String adminEditProfile = '/admin-edit-profile';
  static const String patientEditProfile = '/patient-edit-profile';
  static const String privacyPolicy = '/privacy-policy';
  static const String sectionDoctors = '/section-doctors';

  static const _authRoutes = {onboarding, chooseRole, login, signUp};
  static const _shellRoutes = {home, favourites, patientAppointments, profile};
  static const _patientRoutes = {
    findDoctors,
    doctorDetails,
    appointmentBooking,
    patientAppointmentDetails,
    patientEditProfile,
    privacyPolicy,
    sectionDoctors,
  };
  static const _adminRoutes = {
    admin,
    adminAppointments,
    adminSettings,
    createDoctor,
    editDoctor,
    adminDoctorDetails,
    adminDoctorAvailability,
    adminAppointmentDetails,
    adminEditProfile,
  };

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    refreshListenable: getIt<AuthRoleNotifier>(),
    redirect: (context, state) {
      final auth = getIt<AuthRoleNotifier>().value;
      final status = auth.status;
      final path = state.matchedLocation;

      if (status == AuthSessionStatus.unknown) return splash;

      if (status == AuthSessionStatus.authenticated) {
        final isAdmin = auth.role == Role.admin;
        if (isAdmin) {
          if (path == splash ||
              _authRoutes.contains(path) ||
              _patientRoutes.contains(path) ||
              _shellRoutes.contains(path)) {
            return admin;
          }
        } else if (path == splash ||
            _authRoutes.contains(path) ||
            _adminRoutes.contains(path)) {
          return home;
        }
      }

      if (status == AuthSessionStatus.unauthenticated) {
        if (path == splash ||
            _shellRoutes.contains(path) ||
            _adminRoutes.contains(path) ||
            _patientRoutes.contains(path)) {
          return chooseRole;
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
        path: sectionDoctors,
        builder: (context, state) {
          final args = state.extra as (String, List<Doctor>);
          return SectionDoctorsScreen(title: args.$1, doctors: args.$2);
        },
      ),
      GoRoute(
        path: doctorDetails,
        builder: (context, state) =>
            DoctorDetailsScreen(doctor: state.extra as Doctor),
      ),
      GoRoute(
        path: appointmentBooking,
        builder: (context, state) => AppointmentBookingScreen(doctor: state.extra as Doctor),
      ),
      GoRoute(
        path: patientAppointmentDetails,
        builder: (context, state) => PatientAppointmentDetailsScreen(
          appointment: state.extra as Appointment,
        ),
      ),
      GoRoute(
        path: createDoctor,
        builder: (context, state) {
          final (cubit, doctor) = state.extra as (ManageDoctorsCubit, Doctor?);
          return DoctorFormScreen(cubit: cubit, doctor: doctor);
        },
      ),
      GoRoute(
        path: editDoctor,
        builder: (context, state) {
          final (cubit, doctor) = state.extra as (ManageDoctorsCubit, Doctor?);
          return DoctorFormScreen(cubit: cubit, doctor: doctor);
        },
      ),
      GoRoute(
        path: patientEditProfile,
        builder: (context, state) => BlocProvider.value(
          value: state.extra as UserCubit,
          child: const PatientEditProfileScreen(),
        ),
      ),
      GoRoute(
        path: privacyPolicy,
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AdminShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: admin,
                builder: (context, state) => const ManageDoctorsScreen(),
              ),
              GoRoute(
                path: adminDoctorDetails,
                builder: (context, state) {
                  final (cubit, doctor) =
                      state.extra as (ManageDoctorsCubit, Doctor);
                  return BlocProvider.value(
                    value: cubit,
                    child: AdminDoctorDetailsScreen(doctor: doctor),
                  );
                },
              ),
              GoRoute(
                path: adminDoctorAvailability,
                builder: (context, state) {
                  final (cubit, doctor) =
                      state.extra as (ManageDoctorsCubit, Doctor);
                  return BlocProvider.value(
                    value: cubit,
                    child: AdminDoctorAvailabilityScreen(doctor: doctor),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: adminAppointments,
                builder: (context, state) => const AdminAppointmentsScreen(),
              ),
              GoRoute(
                path: adminAppointmentDetails,
                builder: (context, state) {
                  final args = state.extra as (AdminAppointmentsCubit, Appointment);
                  return BlocProvider.value(
                    value: args.$1,
                    child: AdminAppointmentDetailsScreen(
                      appointment: args.$2,
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: adminSettings,
                builder: (context, state) => const AdminSettingsScreen(),
              ),
              GoRoute(
                path: adminEditProfile,
                builder: (context, state) => BlocProvider.value(
                  value: state.extra as UserCubit,
                  child: const AdminEditProfileScreen(),
                ),
              ),
            ],
          ),
        ],
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
                path: patientAppointments,
                builder: (context, state) => const PatientAppointmentsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: profile,
                builder: (context, state) => const PatientSettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
