# Admin Feature Re-architecture & Doctors List Plan

## Goal Description
The goal of this plan is to review and re-architect the existing `admin` feature to cleanly separate the `manage_doctors`, `settings`, and upcoming `appointments` domains. Currently, all admin UI (including the shell and settings) is coupled inside the `manage_doctors` directory. 

After structural refactoring, we will verify that the "Admin — Doctors List (with Stats)" and "Admin — Doctors List (Empty State)" fully match the provided Figma screenshots. The existing implementation already has the required components (`DoctorStatsCard`, `DoctorSearchBar`, `EmptyDoctorsView`, `DoctorListItem`), so this task focuses primarily on folder separation, route wiring, and UI polishing to match the design.

## User Review Required
> [!WARNING]
> **Directory Restructuring**: This plan moves several files and changes the `admin` feature folder layout. Please review the "Proposed Changes" to ensure the new folder structure aligns with your feature-first expectations.

## Open Questions
> [!IMPORTANT]
> 1. **Figma Polish**: The existing `manage_doctors` code already contains widgets for stats, search, and empty states. Are there any specific visual discrepancies between the current app and the Figma screenshots that you've noticed and want fixed?
> 2. **Appointments Tab**: Should we add a placeholder `AdminAppointmentsScreen` right now to complete the 3-tab bottom navigation bar shown in the Figma design?

## Proposed Changes

We will split the `lib/apps/features/admin` folder into distinct features: `shell`, `manage_doctors`, `settings`, and `appointments`.

---

### `lib/apps/features/admin/shell/`
This feature will own the bottom navigation and the `StatefulShellRoute` scaffolding.

#### [NEW] `presentation/widgets/admin_shell.dart`
Moved from `manage_doctors`.

#### [NEW] `presentation/widgets/admin_bottom_nav_bar.dart`
Moved from `manage_doctors`. 
**Updates**: Add the "Appointments" `NavigationDestination` between "Doctors" and "Settings" to match the Figma layout.

---

### `lib/apps/features/admin/settings/`
This feature will own the admin settings and profile management.

#### [NEW] `presentation/screens/admin_settings_screen.dart`
Moved from `manage_doctors`.

---

### `lib/apps/features/admin/appointments/`
This feature will own the upcoming admin appointments operations.

#### [NEW] `presentation/screens/admin_appointments_screen.dart`
A simple placeholder screen so the bottom navigation bar can function correctly.

---

### `lib/apps/features/admin/manage_doctors/`
This feature will now strictly contain only logic and UI for managing doctors.

#### [DELETE] `presentation/widgets/admin_shell.dart`
#### [DELETE] `presentation/widgets/admin_bottom_nav_bar.dart`
#### [DELETE] `presentation/screens/admin_settings_screen.dart`

---

### `lib/apps/core/router/app_router.dart`
Update the router to reflect the new file locations and add the new branch for appointments.

#### [MODIFY] `app_router.dart`
```dart
// 1. Update imports for AdminShell and AdminSettingsScreen.
// 2. Add an adminAppointments route constant.
// 3. Update the StatefulShellRoute.indexedStack to have 3 branches:
//    - admin (ManageDoctorsScreen)
//    - adminAppointments (AdminAppointmentsScreen)
//    - adminSettings (AdminSettingsScreen)
```

## Verification Plan

### Automated Tests
Run static analysis to ensure no broken imports or unhandled routing errors after moving files:
`flutter analyze`

### Manual Verification
1. Log in as an Admin.
2. Verify the Bottom Navigation Bar displays three tabs: Doctors, Appointments, Settings.
3. Verify navigation between the three tabs works without errors.
4. Verify the "Doctors" tab correctly displays the stats, search, specialty filters, list, and "+ Add Doctor" FAB.
5. Search for a non-existent doctor to verify the "Empty State" screen looks exactly like the Figma screenshot.
