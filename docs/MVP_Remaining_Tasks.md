# Doctor Hunt - Remaining MVP Tasks

Based on a review of the current codebase against the `Doctor_Hunt_MVP_Feature_Scope.md`, the following features are missing and must be implemented to fulfill the Minimum Viable Product scope.

## 1. Patient App

### Appointments Module
- **Appointments Tabs:** Create an `appointments` feature containing Upcoming, Completed, and Cancelled tabs.
- **Cancel Booking:** Allow patients to cancel "Upcoming" bookings.

### Review & Ratings Engine
- **Rate Doctor Flow:** After an appointment is "Completed", enable patients to submit a 1-5 star rating and an optional comment.
- **Display Ratings:** Update the Doctor Details screen to show actual aggregated ratings and recent patient reviews, rather than static mock data.

### Profile & Settings
- **Profile Data:** Expand `profile_screen.dart` to display and edit Photo, Full Name, Email, Phone, DOB, and Gender.
- **Settings:** Add Change Password, Notifications toggle, and Language settings.

### Out-of-Scope Cleanup
- **Remove `chat`:** The in-app chat folder exists but is explicitly marked out of scope for the MVP.
- **Remove Live Doctors:** The `live_doctors_section.dart` on the Home screen is out of scope.

---

## 2. Admin App

### Doctor Form & Availability Engine
- **Doctor Profile Fields:** Add "Fee" (Price) and "Photo" upload to the Create/Edit Doctor form (`doctor_form_body.dart`).
- **Availability Setup:** Create an interface for Admins to define a doctor's Working Days (Mon-Sun), Working Hours (Start/End time), and Slot Duration.

### Appointments Operations
- **Admin Appointments View:** Implement an appointments management screen with 4 tabs (All, Upcoming, Completed, Cancelled).
- **Appointment Actions:** Allow admins to Mark Appointments as "Completed" or "Cancel" them.
- **Patient Info:** Embed basic patient contact info inside the Admin's view of an appointment.

### Admin Settings & Central Clinic Location
- **Central Location:** Implement the single Admin "Clinic Location" field in the Admin Settings screen. This must act as the single source of truth for all doctor locations shown in the Patient app.
- **Admin Profile:** Allow editing of the Admin's Photo, Full Name, and Email.

---

## 3. Core Architecture & Data Models

- **Missing Models:** Create data models for `Appointment` and `Review` (including Firestore serialization).
- **Model Updates:** Update the `Doctor` model to support availability references and aggregated rating statistics.
