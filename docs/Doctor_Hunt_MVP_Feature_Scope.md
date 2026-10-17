# Doctor Hunt — MVP Feature Scope

> **Product Specification & Architecture Blueprint**  
> **LOCKED MVP SCOPE**

## 1. Project Overview & Single Core Journey

Doctor Hunt is a streamlined doctor discovery and appointment booking system focused strictly on solving a single linear patient journey without operational overhead.

**Core Journey**

1. Find Doctor
2. Doctor Details
3. Book Slot
4. Manage Booking
5. Rate Doctor

### System Composition

- **Patient App:** Doctor discovery, slot booking, status tracking & reviews.
- **Admin App:** Doctor management, availability rules & appointment control.
- **Shared Architecture:** 1 central clinic location set by Admin.

### Core Architectural Invariants

- **No Doctor App / Login:** Managed entirely by the Clinic Admin.
- **No Doctor-Specific Location:** All doctors inherit Admin Clinic Location.
- **No Complex States:** Strictly Upcoming, Completed, Cancelled.

---

## 2. Explicitly Out of Scope (Locked Matrix)

The original design contains extensive modules intentionally removed to keep the MVP agile and stable:

- Live Doctors
- Medical Records
- Diagnostic Tests
- Medicines / Orders
- My Doctors
- Health Packages
- Online Consultation
- In-App Chat
- Payments / Gateways
- Multiple Profiles
- Facebook / Apple Login
- Doctor Experience Years
- Doctor-specific Location
- Admin Analytics Dashboard
- Admin Roles & Permissions
- Admin Self-Registration (Future)

---

## 3. Onboarding, Role Selection & Authentication

### 3.1 Onboarding & Role

- Splash Screen & Onboarding Screens (Skip / Get Started).
- Choose Role: Select Patient vs Admin before entering Auth.
- Role Architecture: Kept at entry point to support future Admin self-registration without changing app navigation.

### 3.2 Authentication

**Patient**
- Sign Up
- Login
- Google Sign-In
- Forgot / Reset Password

**Admin**
- Login only (Email + Password)
- Self Sign-Up is Future-Ready.

**Session**
- Secure Logout via App Settings.

### 3.3 Patient Home Screen

- Patient Greeting & Profile Avatar
- Doctor Search Bar
- Specialty Chips
- Popular Doctors — sorted by `reviewsCount` descending (Active doctors only)
- "See All" → Doctors list sorted by popularity
- Top Rated Doctors — sorted by `rating` descending (Active doctors only)
- "See All" → Doctors list sorted by rating

---

## 4. Discovery, Favorites & Single Location Architecture

### 4.1 Doctor Discovery & Card Data

**Listing**
- Search by name
- Filter by medical specialty

**Doctor Card Components**
- Image
- Full Name
- Specialty
- Rating & Review Count
- Fee
- Favorite Heart
- "Book Now" CTA

**Home Doctor Sections**
- Popular Doctors → ordered by `reviewsCount`
- Top Rated Doctors → ordered by `rating`

**Favorites**
- Save/remove doctor for rapid 1-tap access.

### 4.2 Doctor Details, Rating & Location Rule

**Doctor Details**
- Profile photo
- Name
- Specialty
- Fee
- Rating summary (e.g. `4.7 · 24 Reviews`)
- Recent Reviews
- Clinic Location
- Available slots

**Admin Central Location**
- Doctor location is not entered per doctor.
- Displays the single Admin Location.
- Changing it in Admin updates all doctors.

---

# Patient Booking, Appointments & Reviews

## 5. The 4-Step Booking Flow

### Step 1: Select Date

From Doctor Details → **Book Now**.

Calendar displays dates generated from doctor's active working days.

### Step 2: Select Time Slot

Presents generated slots (e.g. `09:00 AM`, `09:30 AM`, `10:00 AM`) based on doctor's availability rules.

### Step 3: Review Appointment

Displays:
- Doctor Name
- Specialty
- Date & Time
- Fee
- Clinic Location (Central Admin Location)

### Step 4: Confirm Booking

Click **Confirm** → Status set to **Upcoming** → Success confirmation screen displayed.

---

## 6. Appointment States (3-State Rule)

### 1. Upcoming

- Patient can Cancel.
- Admin can Cancel or Mark Completed.

### 2. Completed

- Consultation concluded.
- Unlocks doctor review & rating eligibility.

### 3. Cancelled

- Terminated by patient or admin.
- View only.
- Cannot review.

---

## 7. Reviews & Ratings Engine (Post-Appointment)

### 7.1 Review Flow & Strict Eligibility

**Eligibility Condition**

Strictly:

`Appointment.status == completed`

Patients cannot review Upcoming or Cancelled visits.

**Submission Flow**

`Completed → Rate Doctor → Select 1–5 Stars → Optional Comment → Submit → Review Added`

### 7.2 Review Schema & Out-of-Scope Rules

**Review Schema**

- `id`
- `appointmentId`
- `patientId`
- `doctorId`
- `rating` (1–5)
- `comment`
- `createdAt`

**Doctor Aggregation**

- Doctor document keeps aggregated rating (`avg`) & `reviewsCount`.
- Full reviews live in the `reviews` collection.

**Doctor Details Display**

Shows:
- Aggregate rating (e.g. `4.7 · 24 Reviews`)
- Recent patient comments

**Strict Exclusions**

- No doctor replies
- No likes
- No review reports
- No photos
- No moderation dashboard
- No edit history

---

## 8. Patient Profile & Navigation Structure

### 8.1 Profile & Minimal Settings

**Profile**
- Photo
- Full Name
- Email
- Phone
- DOB
- Gender
- View / Edit

**Settings**
- Change Password
- Notifications toggle
- Language
- Logout confirmation modal

### 8.2 Patient App — 4-Tab Navigation

| Tab | Key Screens & Actions |
|---|---|
| **Home** | Search bar, Specialties, Popular & Top Rated Doctors |
| **Doctors** | Discovery list, Specialty filters, Favorites |
| **Appointments** | Upcoming (Cancel), Completed (Rate Doctor), Cancelled |
| **Profile** | Edit info, Security, Settings & Logout |

---

# Admin Operations & Detailed Workflows

## 9. Admin Core Management Modules

### 9.1 Admin Login Flow

Admin authentication is strictly **Email + Password**.

No self-registration in MVP (Future-ready architecture).

**Flow**

`Choose Role → Admin → Admin Login → Email + Password → Success → Doctors List`

### 9.2 Create Doctor Flow

**Strict Rule:** No Location or Experience fields in Create Doctor. Location is inherited centrally from Admin.

**Flow**

`Doctors → Add Doctor → Enter [Photo, Name, Specialty, Fee] → Create → Doctors List`

### 9.3 Doctors Management Directory

Controls doctor discovery listing, filtering, and live operational status.

**Listing & Filtering**
- Total / Active counters
- Search by name
- Filter by specialty

**Edit Profile**
- Update Doctor Photo
- Name
- Specialty
- Fee

**Status Switch**
- Activate / Deactivate instead of permanent deletion to preserve booking histories.

**Flow**

`Admin → Doctors → Search/Filter → Select Doctor → Details [Edit | Availability | Status]`

### 9.4 Doctor Availability Engine

Defines doctor schedule so the system can generate valid patient booking slots.

**Working Days**
- Monday through Sunday toggle flags.

**Working Hours**
- Start & End time (e.g. `09:00 AM → 05:00 PM`)

**Slot Duration**
- Configurable interval (e.g. `30 Minutes`)

**Flow**

`Doctor Details → Availability → Select Days → Set Hours → Set Slot Duration → Save → Generates Booking Slots`

### 9.5 Appointments Operations

Admin manages all patient bookings across 4 primary tabs:

- All
- Upcoming
- Completed
- Cancelled

**Upcoming Actions**
- Cancel
- Mark Completed

**Completed / Cancelled**
- View Only

**Patient Data**
- Basic contact info is displayed inside appointment details.
- No standalone Patients module in MVP.

### 9.6 Admin Profile & Central Location

The single source of truth for the physical clinic location across the entire platform.

**Admin Data**
- Photo
- Full Name
- Email
- Clinic Location

**Location Propagation**

When Admin updates the Clinic Location, it instantly updates on:
- Doctor Details
- Slot
- Review & Appointment Details for all doctors

**Flow**

`Admin Settings → Admin Profile → Edit [Photo, Name, Email, Clinic Location] → Save → Central Location Updated`

---

# System Architectures & Master Feature Matrix

## 10. Complete Admin Workflow Architecture

```text
ADMIN LOGIN
    │
    ▼
DOCTORS LIST
    ├── Search / Specialties
    └── Add / Create Doctor
            │
            ▼
      Doctor Details
            ├── Edit Doctor Profile
            ├── Manage Availability
            └── Active / Inactive Status
                    │
                    ▼
             GENERATED SLOTS
             Open for Patient Booking

ADMIN APPOINTMENTS
    │
    ▼
Appointment Details
(Embedded Patient Info)
    ├── CANCEL
    └── MARK COMPLETED
            │
            ▼
       PATIENT RATES
```

---

## 11. Final Master Feature Checklist

### Patient App Feature Checklist

- [x] Onboarding & Splash
- [x] Choose Role Entry
- [x] Email / Pass Auth
- [x] Google Sign-In
- [x] Reset Password Flow
- [x] Home Screen & Search
- [x] Popular Doctors
- [x] Top Rated Doctors
- [x] Specialty Filters
- [x] Doctor Details & Location
- [x] Favorites Add / Remove
- [x] Select Booking Date / Slot
- [x] Review & Confirm Booking
- [x] Upcoming / Completed / Cancelled Tabs
- [x] Cancel Upcoming Booking
- [x] Rate Doctor (1–5 Stars)
- [x] Optional Review Comment
- [x] View Doctor Ratings

### Admin App Feature Checklist

- [x] Choose Role → Admin
- [x] Admin Login Auth
- [x] Doctor List & Counters
- [x] Search & Filter Doctors
- [x] Create Doctor Profile
- [x] Edit Doctor Profile
- [x] Activate / Deactivate
- [x] Working Days Setup
- [x] Working Hours & Slots
- [x] 4 Appointment Tabs (All / Up / Comp / Can)
- [x] Embedded Patient Info
- [x] Mark Appointment Completed
- [x] Cancel Appointment
- [x] View Rating & Review Count
- [x] Update Central Location
- [x] Admin Settings & Logout
