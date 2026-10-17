# 🩺 Doctor Hunt

A modern, full-featured doctor discovery and appointment booking Flutter application. Built with **Clean Architecture**, **Feature-First structure**, **BLoC / Cubit** state management, **Firebase** (Auth & Cloud Firestore), and **Cloudinary** media integration.

---

## 📑 Table of Contents

- [Overview](#-overview)
- [Key Features](#-key-features)
  - [Patient Experience](#-patient-experience)
  - [Clinic Admin Operations](#-clinic-admin-operations)
- [Architectural Highlights](#-architectural-highlights)
  - [Layering & Pattern](#layering--pattern)
  - [State Management & DI](#state-management--di)
  - [Declarative Routing & Role Guards](#declarative-routing--role-guards)
  - [Central Clinic Location Architecture](#central-clinic-location-architecture)
- [Tech Stack & Packages](#-tech-stack--packages)
- [Project Directory Structure](#-project-directory-structure)
- [Data Models & Collections](#-data-models--collections)
- [Getting Started & Setup](#-getting-started--setup)
  - [Prerequisites](#prerequisites)
  - [Environment Variables (`.env`)](#environment-variables-env)
  - [Code Generation & Build Commands](#code-generation--build-commands)
  - [Running the App & Tests](#running-the-app--tests)
- [Design Tokens & Localization](#-design-tokens--localization)

---

## 🌟 Overview

**Doctor Hunt** streamlines the healthcare discovery and booking process by delivering a smooth, end-to-end journey for patients and complete practice management for clinic administrators.

### Core Journey:
1. **Discover Doctor**: Search by name or filter by medical specialty.
2. **Review Profile**: View doctor details, consultation fees, and reviews.
3. **Book Appointment**: Select available dates & generated time slots in real time.
4. **Manage Booking**: Track Upcoming, Completed, or Cancelled appointments.
5. **Rate & Review**: Leave a 1–5 star rating and feedback upon completed visits.

---

## ✨ Key Features

### 👤 Patient Experience

- **Onboarding & Role Choice**:
  - 3-step walkthrough introducing key app capabilities.
  - Role selection entrypoint (`Patient` vs. `Admin`).
- **Authentication**:
  - Email & Password Sign-Up and Sign-In with real-time field validation.
  - Google Sign-In via Google OAuth.
  - Password recovery / reset password flow.
  - Session auto-persistence and role-based initial routing.
- **Home Dashboard**:
  - Personalized patient greeting with profile avatar.
  - Quick-search bar with debounced query handling.
  - Specialty categories (Cardiologist, Dentist, Pediatrician, Neurologist, etc.).
  - **Popular Doctors** (ranked by review counts) with "See All" view.
  - **Top Rated Doctors** (ranked by average rating) with "See All" view.
- **Doctor Discovery & Details**:
  - Filter doctors dynamically by specialty tags.
  - View doctor biography, specialty, consultation fees, and ratings.
  - Interactive Clinic Location map card (inheriting the clinic's central address).
  - Add/remove doctors from **Favorites** for 1-tap quick access.
- **Dynamic Slot Booking Flow**:
  - **Step 1: Select Date** – Syncfusion datepicker constrained to doctor's active working days.
  - **Step 2: Select Time Slot** – Generated time slots categorized into Morning, Afternoon, and Evening based on doctor availability rules and slot duration.
  - **Step 3: Review Appointment** – Summary card displaying doctor info, date, time, fee, and location.
  - **Step 4: Confirmation** – Instant Firestore sync and booking confirmation modal.
- **Appointments Management**:
  - Tabbed overview: **Upcoming**, **Completed**, and **Cancelled**.
  - Patient-initiated cancellation with confirmation dialogs.
  - **Ratings & Reviews Engine**: 1–5 star rating and optional comments unlocked strictly for completed appointments.
- **Profile & Settings**:
  - Edit personal information (Full Name, Phone Number, Profile Photo via Cloudinary).
  - Security settings (Change password).
  - App privacy policy and custom logout confirmation dialog.
  - ZoomDrawer side navigation menu with shadow and smooth gesture animations.

---

### 🛡️ Clinic Admin Operations

- **Admin Authentication & Access Control**:
  - Secure credential-based login.
  - Protected administrative route guards.
- **Doctor Directory Management**:
  - Real-time counters: **Total Doctors**, **Active**, and **Inactive**.
  - Search doctors by name and filter by medical specialty.
  - Create new doctor profiles with photo upload, specialty, and consultation fees.
  - Edit existing doctor details or toggle status (`Active & Available` vs. `Inactive`) to preserve appointment histories without destructive deletions.
- **Doctor Availability Engine**:
  - Configure working days (Monday through Sunday toggles).
  - Set working hours (Start Time and End Time).
  - Set custom appointment slot durations (e.g., 30 minutes).
  - Automatically updates patient slot generation.
- **Appointment Operations**:
  - Manage all clinic appointments across tabs: **Upcoming**, **Completed**, and **Cancelled**.
  - Detailed appointment view with embedded patient contact info.
  - Mark appointments as **Completed** or **Cancelled** with confirmation dialogs.
- **Central Clinic Location Architecture**:
  - Single administrative setting for the physical clinic location.
  - Updates propagate across all doctor cards, booking reviews, and appointment details.
- **Admin Profile & Settings**:
  - Update Admin Full Name, Email, Profile Photo, and Clinic Location.
  - App build version information and secure logout.

---

## 🏗️ Architectural Highlights

### Layering & Pattern

The project follows a **Feature-First** structure divided into `common`, `patient`, and `admin` roles, combined with **Clean Architecture** patterns:

```
lib/
├── apps/
│   ├── core/                    # Shared infrastructure across features
│   │   ├── auth/                # Session & AuthRoleNotifier
│   │   ├── di/                  # Injectable & GetIt service locator
│   │   ├── error/               # Failures & error mapping
│   │   ├── extensions/         # Context, SnackBar & style extensions
│   │   ├── models/              # Shared entities (Doctor, Appointment, UserProfile, Role)
│   │   ├── router/              # Central GoRouter configuration
│   │   ├── services/            # Image upload (Cloudinary) & common services
│   │   ├── theme/               # Figma design tokens & AppColors
│   │   ├── utils/               # Constants, Validators, Asset paths
│   │   └── widgets/             # Reusable UI widgets & shells
│   └── features/
│       ├── common/              # Onboarding, Auth, Choose Role, Profile
│       ├── patient/             # Home, Find Doctors, Details, Booking, Appointments, Favourites
│       └── admin/               # Shell, Manage Doctors, Appointments, Settings
```

- **Clean Architecture Exemplar (`auth`)**:
  - `domain/`: Abstract repository contracts and use cases (`SignInUseCase`, `SignUpUseCase`, `SignOutUseCase`).
  - `data/`: Remote data source (`FirebaseAuthRemoteDataSource`) and repository implementation (`AuthRepositoryImpl`).
  - `presentation/`: BLoC/Cubit (`AuthCubit`), screen widgets, and form validators.

### State Management & DI

- **BLoC / Cubit (`flutter_bloc`)**: State is emitted via immutable states; screen-scoped cubits are registered as GetIt factories and provisioned via `BlocProvider(create: (_) => getIt<XCubit>()..load())`.
- **GetIt & Injectable**: Annotations `@lazySingleton`, `@injectable`, and `@module` handle dependency injection. Hand-written setup lives in `core/di/injection.dart`, while wiring is generated into `injection.config.dart`.

### Declarative Routing & Role Guards

- **GoRouter**: Centralized in `core/router/app_router.dart`.
- **`AuthRoleNotifier`**: App-wide session listener that drives router redirects based on authentication status and user role:
  - Unauthenticated users are redirected to `/choose-role` or `/login`.
  - Authenticated patients are routed to `/home` with the 4-tab `AppShell` (ZoomDrawer).
  - Authenticated administrators are routed to `/admin` with the 3-tab `AdminShell`.

### Central Clinic Location Architecture

Instead of duplicating clinic location per doctor, the single clinic address set by the Admin in settings serves as the single source of truth across all doctor profile cards, appointment booking steps, and appointment summaries.

---

## 🧰 Tech Stack & Packages

| Category | Technology / Package | Description |
|---|---|---|
| **Framework** | Flutter 3.4+ / Dart 3 | Cross-platform UI toolkit |
| **State Management** | `flutter_bloc` (^9.0.0) | Predictable state container using Cubits |
| **Dependency Injection** | `get_it` (^8.1.0) & `injectable` (^2.5.0) | Service locator and DI generator |
| **Routing** | `go_router` (^16.0.0) | Declarative navigation with shell routes & role guards |
| **Backend & Database** | `firebase_core`, `firebase_auth`, `cloud_firestore` | Authentication & NoSQL Cloud Firestore |
| **Cloud Storage** | `cloudinary_public` (^0.23.1) | Cloud-based image upload for avatars and doctors |
| **Localization** | `slang` & `slang_flutter` (^4.19.0) | Type-safe JSON localization |
| **UI & Styling** | `flutter_screenutil` (^5.9.0) | Adaptive layout matching 375×812 Figma spec |
| **Navigation Shell** | `flutter_zoom_drawer` (^3.2.0) | Drawer navigation for patient view |
| **Date & Time Picker** | `syncfusion_flutter_datepicker` (^34.2.5) | Custom calendar date selection |
| **Utilities** | `cached_network_image`, `flutter_svg`, `easy_debounce`, `pin_code_fields`, `shared_preferences` | Performance & UI helpers |
| **Testing** | `mocktail`, `bloc_test`, `flutter_test` | Unit, cubit, and widget testing suite |

---

## 📁 Project Directory Structure

```text
lib/
├── app.dart                                # Root DoctorHuntApp widget
├── firebase_options.dart                   # Firebase CLI platform options
├── generate_styles.dart                    # Generator script for atomic typography
├── main.dart                               # Application entrypoint
├── generated/
│   └── style_atoms.dart                    # Generated context typography atoms
├── i18n/
│   ├── en.i18n.json                        # Master English translation strings
│   ├── strings.g.dart                      # Generated Slang base file
│   └── strings_en.g.dart                   # Generated Slang English translations
└── apps/
    ├── core/
    │   ├── auth/                           # AuthRoleNotifier & session state
    │   ├── di/                             # Injection container & modules
    │   ├── error/                          # AuthFailure & error mappers
    │   ├── extensions/                     # Helper extensions (snackbar, theme, error)
    │   ├── models/                         # Shared Doctor & Appointment models
    │   ├── router/                         # AppRouter with GoRouter & guards
    │   ├── services/                       # ImageUploadService (Cloudinary)
    │   ├── theme/                          # AppColors token palette
    │   ├── utils/                          # AppConstants, AppValidator, ImageAssets
    │   └── widgets/                        # AppShell, AdminShell, Dialogs, Buttons
    └── features/
        ├── common/
        │   ├── appointments/               # Shared appointment repo/service contracts
        │   ├── auth/                       # Clean Architecture Auth (domain/data/presentation)
        │   ├── choose_role/                # Patient vs. Admin role selection
        │   ├── onboarding/                 # Onboarding carousel screens
        │   └── profile/                    # UserProfile data, UserService, UserCubit
        ├── patient/
        │   ├── appointment_booking/        # Booking calendar, time slot grid, review dialog
        │   ├── appointments/               # Tabbed patient appointments, cancel, rate doctor
        │   ├── doctor_details/             # Doctor details screen, services, clinic map
        │   ├── favourite_doctors/          # Saved favorite doctors list
        │   ├── find_doctors/               # Doctor search & specialty filters
        │   ├── home/                       # Patient home dashboard, categories, doctor sections
        │   └── profile/                    # Patient settings, edit profile, privacy policy
        └── admin/
            ├── appointments/               # Admin appointments management & status transitions
            ├── manage_doctors/             # Doctor CRUD, availability setup, status toggle
            ├── settings/                   # Admin profile, central clinic location, app version
            └── shell/                      # AdminShell & persistent bottom navigation bar
```

---

## 🗄️ Data Models & Collections

### Cloud Firestore Collections

- **`users`**: User profile information keyed by Firebase UID.
  - `name`, `email`, `phone`, `photoUrl`, `role` (`patient` | `admin`), `clinicLocation` (for admins).
- **`doctors`**: Doctor listings managed by clinic admins.
  - `name`, `specialty`, `price`, `photo`, `rating`, `reviewsCount`, `isActive`, `adminId`, `workingDays`, `startTime`, `endTime`, `slotDuration`.
- **`appointments`**: Bookings between patients and doctors.
  - `patientId`, `patientName`, `patientEmail`, `patientPhotoUrl`, `doctorId`, `doctorName`, `doctorSpecialty`, `doctorPhotoUrl`, `date`, `time`, `fee`, `status` (`upcoming` | `completed` | `cancelled`), `clinicLocation`, `rating`, `reviewComment`.

---

## 🚀 Getting Started & Setup

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`^3.4.0` or higher)
- [Dart SDK](https://dart.dev/get-dart) (`^3.4.0`)
- Android Studio / Xcode for device simulation or physical debugging
- Firebase account with a configured project

### Environment Variables (`.env`)

Create a `.env` file in the project root based on `.env.example`:

```properties
CLOUDINARY_CLOUD_NAME=your_cloudinary_cloud_name
CLOUDINARY_UPLOAD_PRESET=your_unsigned_upload_preset
```

### Code Generation & Build Commands

When updating dependencies, localization files, typography tokens, or dependency registrations, execute the respective generator:

```bash
# 1. Fetch dependencies
flutter pub get

# 2. Generate Dependency Injection (GetIt / Injectable)
dart run build_runner build --delete-conflicting-outputs

# 3. Generate Localization Strings (Slang)
dart run slang

# 4. Generate Typography Style Atoms
dart run lib/generate_styles.dart

# 5. Configure Firebase (if updating platforms)
flutterfire configure
```

### Running the App & Tests

```bash
# Run the application
flutter run

# Run static analysis
flutter analyze

# Run unit and widget tests
flutter test
```

---

## 🎨 Design Tokens & Localization

### Design Tokens & Typography

- **Colors**: Defined centrally in `lib/apps/core/theme/app_colors.dart` matching Figma tokens (e.g. `AppColors.green`, `AppColors.dark`, `AppColors.greyPaleBlue`).
- **Typography Atoms**: Generated into `lib/generated/style_atoms.dart` from `generate_styles.dart`. Accessible directly on `BuildContext`:
  ```dart
  Text('Doctor Hunt', style: context.semiBold21BlackSoft);
  Text('Specialist', style: context.regular15GreyPaleBlue);
  ```
- **Responsive Dimensions**: Powered by `flutter_screenutil` (e.g., `24.w`, `16.h`, `12.r`, `18.sp`).

### Localization (Slang)

All user-facing strings are localized using `slang`:
- Source file: `lib/i18n/en.i18n.json`.
- Access via `BuildContext`:
  ```dart
  context.t.home.popularDoctor
  context.t.appointmentBooking.confirmBooking
  ```

---

## 🧪 Testing

The codebase includes unit and widget test coverage for core business logic and user flows:

- **Repository Tests**: Verifies data source delegation, authentication mappings, and profile persistence (`auth_repository_impl_test.dart`).
- **Cubit Tests**: Validates state emissions for sign-in, registration, Google auth, and logout (`auth_cubit_test.dart`).
- **Widget Tests**: Verifies UI rendering, form validation, and user interactions (`login_screen_test.dart`).
