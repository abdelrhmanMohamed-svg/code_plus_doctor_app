///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$common$en common = Translations$common$en._(_root);
	late final Translations$onboarding$en onboarding = Translations$onboarding$en._(_root);
	late final Translations$chooseRole$en chooseRole = Translations$chooseRole$en._(_root);
	late final Translations$login$en login = Translations$login$en._(_root);
	late final Translations$signUp$en signUp = Translations$signUp$en._(_root);
	late final Translations$forgotPassword$en forgotPassword = Translations$forgotPassword$en._(_root);
	late final Translations$tabs$en tabs = Translations$tabs$en._(_root);
	late final Translations$profile$en profile = Translations$profile$en._(_root);
	late final Translations$favouriteDoctors$en favouriteDoctors = Translations$favouriteDoctors$en._(_root);
	late final Translations$home$en home = Translations$home$en._(_root);
	late final Translations$doctorData$en doctorData = Translations$doctorData$en._(_root);
	late final Translations$findDoctors$en findDoctors = Translations$findDoctors$en._(_root);
	late final Translations$appointmentBooking$en appointmentBooking = Translations$appointmentBooking$en._(_root);
	late final Translations$doctorDetails$en doctorDetails = Translations$doctorDetails$en._(_root);
	late final Translations$thankYou$en thankYou = Translations$thankYou$en._(_root);
	late final Translations$auth$en auth = Translations$auth$en._(_root);
	late final Translations$createDoctor$en createDoctor = Translations$createDoctor$en._(_root);
	late final Translations$editDoctor$en editDoctor = Translations$editDoctor$en._(_root);
	late final Translations$admin$en admin = Translations$admin$en._(_root);
	late final Translations$adminAppointments$en adminAppointments = Translations$adminAppointments$en._(_root);
	late final Translations$patientAppointments$en patientAppointments = Translations$patientAppointments$en._(_root);
	late final Translations$specialties$en specialties = Translations$specialties$en._(_root);
	late final Translations$adminSettings$en adminSettings = Translations$adminSettings$en._(_root);
	late final Translations$patientSettings$en patientSettings = Translations$patientSettings$en._(_root);
}

// Path: common
class Translations$common$en {
	Translations$common$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Doctor Hunt'
	String get brandName => 'Doctor Hunt';

	/// en: 'Back'
	String get back => 'Back';
}

// Path: onboarding
class Translations$onboarding$en {
	Translations$onboarding$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Find Trusted Doctors'
	String get title1 => 'Find Trusted Doctors';

	/// en: 'Choose Best Doctors'
	String get title2 => 'Choose Best Doctors';

	/// en: 'Easy Appointments'
	String get title3 => 'Easy Appointments';

	/// en: 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.'
	String get body => 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Get Started'
	String get getStarted => 'Get Started';

	/// en: 'Skip'
	String get skip => 'Skip';
}

// Path: chooseRole
class Translations$chooseRole$en {
	Translations$chooseRole$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose Your Role'
	String get title => 'Choose Your Role';

	/// en: 'Select the role that best describes you to continue!'
	String get subtitle => 'Select the role that best describes you to continue!';

	/// en: 'Patient'
	String get patient => 'Patient';

	/// en: 'Book appointments and manage your medical records.'
	String get patientDescription => 'Book appointments and manage your medical records.';

	/// en: 'Admin'
	String get admin => 'Admin';

	/// en: 'Manage doctors, create new doctor profiles, and oversee the platform.'
	String get adminDescription => 'Manage doctors, create new doctor profiles, and oversee the platform.';

	/// en: 'Continue'
	String get continueButton => 'Continue';
}

// Path: login
class Translations$login$en {
	Translations$login$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Welcome back'
	String get welcomeBack => 'Welcome back';

	/// en: 'You can search course, apply course and find scholarship for abroad studies'
	String get joinSubtitle => 'You can search course, apply course and find\nscholarship for abroad studies';

	/// en: 'Forgot Password?'
	String get forgotPassword => 'Forgot Password?';

	/// en: 'Login'
	String get button => 'Login';

	/// en: 'Don't have an account?'
	String get dontHaveAccount => 'Don\'t have an account?';

	/// en: 'Join us'
	String get joinUs => 'Join us';

	/// en: 'Login successful!'
	String get loginSuccess => 'Login successful!';
}

// Path: signUp
class Translations$signUp$en {
	Translations$signUp$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sign Up'
	String get title => 'Sign Up';

	/// en: 'Create your account to continue!'
	String get subtitle => 'Create your account to continue!';

	/// en: 'Full Name'
	String get fullNameFieldLabel => 'Full Name';

	/// en: 'Enter your full name'
	String get fullNameHint => 'Enter your full name';

	/// en: 'Phone Number'
	String get phoneFieldLabel => 'Phone Number';

	/// en: 'Enter your phone number'
	String get phoneHint => 'Enter your phone number';

	/// en: 'Confirm Password'
	String get confirmPasswordFieldLabel => 'Confirm Password';

	/// en: 'Re-enter your password'
	String get confirmPasswordHint => 'Re-enter your password';

	/// en: 'Sign Up'
	String get button => 'Sign Up';

	/// en: 'Already have an account?'
	String get alreadyHaveAccount => 'Already have an account?';

	/// en: 'Join us to start searching'
	String get joinTitle => 'Join us to start searching';

	/// en: 'You can search course, apply course and find scholarship for abroad studies'
	String get joinSubtitle => 'You can search course, apply course and find\nscholarship for abroad studies';

	/// en: 'Google'
	String get googleLabel => 'Google';

	/// en: 'Facebook'
	String get facebookLabel => 'Facebook';

	/// en: 'Name'
	String get nameHint => 'Name';

	/// en: 'Email'
	String get emailHint => 'Email';

	/// en: 'Password'
	String get passwordHint => 'Password';

	/// en: 'I agree with the Terms of Service & Privacy Policy'
	String get termsAgreement => 'I agree with the Terms of Service & Privacy Policy';

	/// en: 'Have an account?'
	String get haveAccount => 'Have an account?';

	/// en: 'Log in'
	String get logIn => 'Log in';
}

// Path: forgotPassword
class Translations$forgotPassword$en {
	Translations$forgotPassword$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Forgot Password'
	String get sheetTitle => 'Forgot Password';

	/// en: 'Enter your email for the verification process, we will send 4 digits code to your email'
	String get sheetBody => 'Enter your email for the verification process, we will send 4 digits code to your email';

	/// en: 'Enter 4 Digits Code'
	String get enterCodeSheetTitle => 'Enter 4 Digits Code';

	/// en: 'Enter the 4 digits code that you received on your email'
	String get enterCodeSheetBody => 'Enter the 4 digits code that you received on your email';

	/// en: 'Reset Password'
	String get resetPasswordSheetTitle => 'Reset Password';

	/// en: 'Set the new password for your account so you can login and access all the features'
	String get resetPasswordSheetBody => 'Set the new password for your account so you can login and access all the features';

	/// en: 'New password'
	String get newPasswordHint => 'New password';

	/// en: 'Re-enter password'
	String get reEnterPasswordHint => 'Re-enter password';

	/// en: 'Update Password'
	String get updatePasswordButton => 'Update Password';
}

// Path: tabs
class Translations$tabs$en {
	Translations$tabs$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Favourites'
	String get favourites => 'Favourites';

	/// en: 'Appointments'
	String get appointments => 'Appointments';

	/// en: 'Profile'
	String get profile => 'Profile';
}

// Path: profile
class Translations$profile$en {
	Translations$profile$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Logout'
	String get logout => 'Logout';

	/// en: 'Create New Doctor'
	String get createDoctor => 'Create New Doctor';

	/// en: 'Couldn't sign you out. Please try again.'
	String get signOutFailure => 'Couldn\'t sign you out. Please try again.';
}

// Path: favouriteDoctors
class Translations$favouriteDoctors$en {
	Translations$favouriteDoctors$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Favourite Doctors'
	String get title => 'Favourite Doctors';

	/// en: 'Dentist'
	String get searchHint => 'Dentist';

	/// en: 'Dr. Shouey'
	String get drShouey => 'Dr. Shouey';

	/// en: 'Dr. Christenfeld N'
	String get drChristenfeldN => 'Dr. Christenfeld N';

	/// en: 'Dentist Specialist'
	String get specalistDentist => 'Dentist Specialist';

	/// en: 'Medicine Specialist'
	String get specalistMedicine => 'Medicine Specialist';

	/// en: 'Cardiology Specialist'
	String get specalistCardiology => 'Cardiology Specialist';

	/// en: 'Cancer Specialist'
	String get specalistCancer => 'Cancer Specialist';

	/// en: 'Feature Doctor'
	String get featureDoctor => 'Feature Doctor';

	/// en: 'Running'
	String get statsRunning => 'Running';

	/// en: 'Ongoing'
	String get statsOngoing => 'Ongoing';

	/// en: 'Patient'
	String get statsPatient => 'Patient';

	/// en: 'Review'
	String get statsReview => 'Review';
}

// Path: home
class Translations$home$en {
	Translations$home$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hi {name}!'
	String greeting({required Object name}) => 'Hi ${name}!';

	/// en: 'Find Your Doctor'
	String get userName => 'Find Your Doctor';

	/// en: 'Search.....'
	String get searchHint => 'Search.....';

	/// en: 'Live Doctors'
	String get liveDoctors => 'Live Doctors';

	/// en: 'Popular Doctor'
	String get popularDoctor => 'Popular Doctor';

	/// en: 'Top Rated Doctors'
	String get featureDoctor => 'Top Rated Doctors';

	/// en: 'See all'
	String get seeAll => 'See all';

	/// en: 'LIVE'
	String get liveBadge => 'LIVE';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: doctorData
class Translations$doctorData$en {
	Translations$doctorData$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Dr. Blessing'
	String get drBlessing => 'Dr. Blessing';

	/// en: 'Dentist Specialist'
	String get drBlessingSpecialty => 'Dentist Specialist';

	/// en: 'Dr. Fillerup Grab'
	String get drFillerupGrab => 'Dr. Fillerup Grab';

	/// en: 'Medicine Specialist'
	String get drFillerupGrabSpecialty => 'Medicine Specialist';

	/// en: 'Dr. Crick'
	String get drCrick => 'Dr. Crick';

	/// en: 'Dr. Lachinet'
	String get drLachinet => 'Dr. Lachinet';

	/// en: 'Dr. Strain'
	String get drStrain => 'Dr. Strain';

	/// en: '25.00/ hours'
	String get priceCrick => '25.00/ hours';

	/// en: '29.00/ hours'
	String get priceLachinet => '29.00/ hours';

	/// en: '22.00/ hours'
	String get priceStrain => '22.00/ hours';
}

// Path: findDoctors
class Translations$findDoctors$en {
	Translations$findDoctors$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Find Doctors'
	String get title => 'Find Doctors';

	/// en: 'No doctors found.'
	String get noResults => 'No doctors found.';

	/// en: 'Dentist'
	String get searchHint => 'Dentist';

	/// en: 'Dr. Shruti Kedia'
	String get drShrutiKedia => 'Dr. Shruti Kedia';

	/// en: 'Dr. Watamaniuk'
	String get drWatamaniuk => 'Dr. Watamaniuk';

	/// en: 'Dr. Crownover'
	String get drCrownover => 'Dr. Crownover';

	/// en: 'Dr. Balestra'
	String get drBalestra => 'Dr. Balestra';

	/// en: 'Tooths Dentist'
	String get toothsDentist => 'Tooths Dentist';

	/// en: '7 Years experience'
	String get experience7Years => '7 Years experience';

	/// en: '9 Years experience'
	String get experience9Years => '9 Years experience';

	/// en: '5 Years experience'
	String get experience5Years => '5 Years experience';

	/// en: '6 Years experience'
	String get experience6Years => '6 Years experience';

	/// en: '87%'
	String get rating87 => '87%';

	/// en: '74%'
	String get rating74 => '74%';

	/// en: '59%'
	String get rating59 => '59%';

	/// en: '69 Patient Stories'
	String get stories69 => '69 Patient Stories';

	/// en: '78 Patient Stories'
	String get stories78 => '78 Patient Stories';

	/// en: '86 Patient Stories'
	String get stories86 => '86 Patient Stories';

	/// en: 'Next Available'
	String get nextAvailable => 'Next Available';

	/// en: '10:00 AM tomorrow'
	String get timeTen => '10:00 AM tomorrow';

	/// en: '12:00 AM tomorrow'
	String get timeTwelve => '12:00 AM tomorrow';

	/// en: '11:00 AM tomorrow'
	String get timeEleven => '11:00 AM tomorrow';

	/// en: 'Book Now'
	String get bookNow => 'Book Now';
}

// Path: appointmentBooking
class Translations$appointmentBooking$en {
	Translations$appointmentBooking$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select Time'
	String get title => 'Select Time';

	/// en: 'No slots available'
	String get noSlotsAvailable => 'No slots available';

	/// en: 'slots available'
	String get slotsAvailable => 'slots available';

	/// en: 'Afternoon'
	String get afternoon => 'Afternoon';

	/// en: 'Evening'
	String get evening => 'Evening';

	/// en: 'Morning'
	String get morning => 'Morning';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'slots'
	String get slots => 'slots';

	/// en: 'Review Appointment'
	String get reviewTitle => 'Review Appointment';

	/// en: 'Doctor'
	String get doctorLabel => 'Doctor';

	/// en: 'Specialty'
	String get specialtyLabel => 'Specialty';

	/// en: 'Date & Time'
	String get dateTimeLabel => 'Date & Time';

	/// en: 'Consultation Fee'
	String get feeLabel => 'Consultation Fee';

	/// en: 'Clinic Location'
	String get locationLabel => 'Clinic Location';

	/// en: 'Confirm Booking'
	String get confirmBooking => 'Confirm Booking';

	/// en: 'Please select a date and time slot'
	String get selectDateAndTime => 'Please select a date and time slot';

	/// en: 'You booked an appointment with Dr. {doctor} on {date}, at {time}'
	String successMessage({required Object doctor, required Object date, required Object time}) => 'You booked an appointment with Dr. ${doctor} on ${date}, at ${time}';
}

// Path: doctorDetails
class Translations$doctorDetails$en {
	Translations$doctorDetails$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Doctor Details'
	String get title => 'Doctor Details';

	/// en: 'Running'
	String get statsRunning => 'Running';

	/// en: 'Ongoing'
	String get statsOngoing => 'Ongoing';

	/// en: 'Patient'
	String get statsPatient => 'Patient';

	/// en: 'Services'
	String get servicesTitle => 'Services';
}

// Path: thankYou
class Translations$thankYou$en {
	Translations$thankYou$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Thank You!'
	String get title => 'Thank You!';

	/// en: 'Appointment Booked'
	String get subtitle => 'Appointment Booked';

	/// en: 'Your appointment has been booked successfully. You will receive a confirmation notification shortly.'
	String get message => 'Your appointment has been booked successfully. You will receive a confirmation notification shortly.';

	/// en: 'Edit Appointment'
	String get editButton => 'Edit Appointment';

	/// en: 'Done'
	String get doneButton => 'Done';
}

// Path: auth
class Translations$auth$en {
	Translations$auth$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No account found with this email.'
	String get userNotFound => 'No account found with this email.';

	/// en: 'Incorrect password. Please try again.'
	String get wrongPassword => 'Incorrect password. Please try again.';

	/// en: 'An account already exists with this email.'
	String get emailAlreadyInUse => 'An account already exists with this email.';

	/// en: 'Password is too weak. Please use a stronger password.'
	String get weakPassword => 'Password is too weak. Please use a stronger password.';

	/// en: 'Please enter a valid email address.'
	String get invalidEmail => 'Please enter a valid email address.';

	/// en: 'Incorrect email or password. Please try again.'
	String get invalidCredentials => 'Incorrect email or password. Please try again.';

	/// en: 'Network error. Please check your connection.'
	String get networkRequestFailed => 'Network error. Please check your connection.';

	/// en: 'Something went wrong. Please try again.'
	String get generic => 'Something went wrong. Please try again.';

	/// en: 'Please accept the Terms of Service to continue.'
	String get termsRequired => 'Please accept the Terms of Service to continue.';

	/// en: 'Please fill in all fields.'
	String get emptyFields => 'Please fill in all fields.';

	/// en: 'This field is required.'
	String get fieldRequired => 'This field is required.';

	/// en: 'Password must be at least 6 characters.'
	String get passwordTooShort => 'Password must be at least 6 characters.';

	/// en: 'Passwords do not match.'
	String get passwordsMismatch => 'Passwords do not match.';

	/// en: 'Google sign-in isn't configured. Please check your Firebase settings.'
	String get googleSignInConfig => 'Google sign-in isn\'t configured. Please check your Firebase settings.';

	/// en: 'Google sign-in failed. Please try again.'
	String get googleSignInError => 'Google sign-in failed. Please try again.';

	/// en: 'You do not have permission to access this resource.'
	String get permissionDenied => 'You do not have permission to access this resource.';
}

// Path: createDoctor
class Translations$createDoctor$en {
	Translations$createDoctor$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Create Doctor'
	String get title => 'Create Doctor';

	/// en: 'DOCTOR NAME'
	String get nameLabel => 'DOCTOR NAME';

	/// en: 'e.g. Dr. Ahmed Ali'
	String get nameHint => 'e.g. Dr. Ahmed Ali';

	/// en: 'SPECIALTY'
	String get specialtyLabel => 'SPECIALTY';

	/// en: 'Select specialty'
	String get specialtyHint => 'Select specialty';

	/// en: 'CONSULTATION FEE'
	String get priceLabel => 'CONSULTATION FEE';

	/// en: 'e.g. $28.00'
	String get priceHint => 'e.g. \$28.00';

	/// en: 'Create Doctor'
	String get submitButton => 'Create Doctor';

	/// en: 'Doctor created successfully!'
	String get successMessage => 'Doctor created successfully!';

	/// en: 'Failed to create doctor. Please try again.'
	String get failureMessage => 'Failed to create doctor. Please try again.';

	/// en: 'Add photo'
	String get addPhoto => 'Add photo';

	/// en: 'Tap photo to change'
	String get changePhoto => 'Tap photo to change';

	/// en: 'Doctor Image'
	String get imageUpload => 'Doctor Image';

	/// en: 'Upload doctor image'
	String get imageUploadHint => 'Upload doctor image';

	/// en: 'Tap to pick an image'
	String get imageUploadTap => 'Tap to pick an image';
}

// Path: editDoctor
class Translations$editDoctor$en {
	Translations$editDoctor$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit Doctor'
	String get title => 'Edit Doctor';

	/// en: 'Save Changes'
	String get submitButton => 'Save Changes';

	/// en: 'Doctor updated successfully!'
	String get successMessage => 'Doctor updated successfully!';

	/// en: 'Failed to update doctor. Please try again.'
	String get failureMessage => 'Failed to update doctor. Please try again.';

	/// en: 'Doctor Status'
	String get statusLabel => 'Doctor Status';

	/// en: 'Active & Available'
	String get statusActive => 'Active & Available';

	/// en: 'Inactive'
	String get statusInactive => 'Inactive';

	/// en: 'Delete Doctor'
	String get deleteDoctor => 'Delete Doctor';
}

// Path: admin
class Translations$admin$en {
	Translations$admin$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Doctors'
	String get doctorsTitle => 'Doctors';

	/// en: 'Appointments'
	String get appointmentsTitle => 'Appointments';

	/// en: 'Settings'
	String get settingsTitle => 'Settings';

	/// en: 'Search doctors...'
	String get searchHint => 'Search doctors...';

	/// en: 'Total Doctors'
	String get totalDoctors => 'Total Doctors';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Inactive'
	String get inactive => 'Inactive';

	/// en: 'Add Doctor'
	String get addDoctor => 'Add Doctor';

	/// en: 'No doctors yet'
	String get emptyStateTitle => 'No doctors yet';

	/// en: 'Create your first doctor to get started.'
	String get emptyStateMessage => 'Create your first doctor to get started.';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Failed to load doctors. Please try again.'
	String get loadFailureMessage => 'Failed to load doctors. Please try again.';

	/// en: 'Filter by specialty'
	String get filterTitle => 'Filter by specialty';

	/// en: 'All'
	String get filterAll => 'All';

	/// en: 'No doctors found'
	String get noResultsTitle => 'No doctors found';

	/// en: 'Try adjusting your search or filters.'
	String get noResultsMessage => 'Try adjusting your search or filters.';

	/// en: 'Edit Doctor'
	String get editDoctor => 'Edit Doctor';

	/// en: 'Delete Doctor'
	String get deleteDoctor => 'Delete Doctor';

	/// en: 'Delete Doctor'
	String get deleteTitle => 'Delete Doctor';

	/// en: 'Are you sure you want to delete this doctor? This action cannot be undone.'
	String get deleteMessage => 'Are you sure you want to delete this doctor? This action cannot be undone.';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Failed to delete doctor. Please try again.'
	String get deleteFailureMessage => 'Failed to delete doctor. Please try again.';

	/// en: 'Doctor Details'
	String get doctorDetailsTitle => 'Doctor Details';

	/// en: 'Manage Availability'
	String get manageAvailability => 'Manage Availability';

	/// en: 'Doctor Availability'
	String get availabilityTitle => 'Doctor Availability';

	/// en: 'Working Days'
	String get workingDays => 'Working Days';

	/// en: '{count} days enabled'
	String daysEnabled({required Object count}) => '${count} days enabled';

	/// en: 'Working Hours'
	String get workingHours => 'Working Hours';

	/// en: 'START TIME'
	String get startTime => 'START TIME';

	/// en: 'END TIME'
	String get endTime => 'END TIME';

	/// en: 'SLOT DURATION'
	String get slotDuration => 'SLOT DURATION';

	/// en: 'Save Availability'
	String get saveAvailability => 'Save Availability';

	/// en: 'Availability updated successfully!'
	String get saveAvailabilitySuccess => 'Availability updated successfully!';

	/// en: 'Failed to update availability.'
	String get saveAvailabilityFailure => 'Failed to update availability.';

	/// en: 'Consultation Fee'
	String get consultationFee => 'Consultation Fee';

	/// en: 'Rating'
	String get rating => 'Rating';

	/// en: '{count} reviews'
	String reviewsCount({required Object count}) => '${count} reviews';

	/// en: 'Specialty'
	String get specialty => 'Specialty';

	/// en: '{count} Minutes'
	String minutes({required Object count}) => '${count} Minutes';
}

// Path: adminAppointments
class Translations$adminAppointments$en {
	Translations$adminAppointments$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Upcoming'
	String get tabUpcoming => 'Upcoming';

	/// en: 'Completed'
	String get tabCompleted => 'Completed';

	/// en: 'Cancelled'
	String get tabCancelled => 'Cancelled';

	/// en: 'Cancel Appointment'
	String get cancelAppointment => 'Cancel Appointment';

	/// en: 'Mark as Completed'
	String get markAsCompleted => 'Mark as Completed';

	/// en: 'View Details'
	String get viewDetails => 'View Details';

	/// en: 'Appointment Details'
	String get appointmentDetailsTitle => 'Appointment Details';

	/// en: 'Patient'
	String get patientSection => 'Patient';

	/// en: 'Doctor'
	String get doctorSection => 'Doctor';

	/// en: 'Appointment'
	String get appointmentSection => 'Appointment';

	/// en: 'Clinic Location'
	String get clinicLocation => 'Clinic Location';

	/// en: 'No appointments found.'
	String get emptyState => 'No appointments found.';

	/// en: 'Are you sure you want to cancel this appointment?'
	String get cancelConfirmation => 'Are you sure you want to cancel this appointment?';

	/// en: 'Mark this appointment as completed?'
	String get completeConfirmation => 'Mark this appointment as completed?';
}

// Path: patientAppointments
class Translations$patientAppointments$en {
	Translations$patientAppointments$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Upcoming'
	String get tabUpcoming => 'Upcoming';

	/// en: 'Completed'
	String get tabCompleted => 'Completed';

	/// en: 'Cancelled'
	String get tabCancelled => 'Cancelled';

	/// en: 'Cancel Appointment'
	String get cancelAppointment => 'Cancel Appointment';

	/// en: 'Rate Doctor'
	String get rateDoctor => 'Rate Doctor';

	/// en: 'View Details'
	String get viewDetails => 'View Details';

	/// en: 'Tap to rate your visit'
	String get tapToRate => 'Tap to rate your visit';

	/// en: 'Submit Rating'
	String get submitRating => 'Submit Rating';

	/// en: 'Review comment (optional)'
	String get reviewComment => 'Review comment (optional)';

	/// en: 'Are you sure you want to cancel this appointment?'
	String get cancelConfirmation => 'Are you sure you want to cancel this appointment?';

	/// en: 'Thank you for your feedback!'
	String get rateSuccess => 'Thank you for your feedback!';

	/// en: 'No appointments found.'
	String get emptyState => 'No appointments found.';

	/// en: 'Your Rating:'
	String get yourRating => 'Your Rating:';

	/// en: 'Date'
	String get dateLabel => 'Date';

	/// en: 'Time'
	String get timeLabel => 'Time';

	/// en: 'Fee'
	String get feeLabel => 'Fee';

	/// en: 'Status'
	String get statusLabel => 'Status';

	/// en: 'Rating'
	String get ratingLabel => 'Rating';

	/// en: 'Clinic Location'
	String get clinicLocation => 'Clinic Location';
}

// Path: specialties
class Translations$specialties$en {
	Translations$specialties$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cardiologist'
	String get cardiologist => 'Cardiologist';

	/// en: 'Orthopedic'
	String get orthopedic => 'Orthopedic';

	/// en: 'Dermatologist'
	String get dermatologist => 'Dermatologist';

	/// en: 'Pediatrician'
	String get pediatrician => 'Pediatrician';

	/// en: 'Neurologist'
	String get neurologist => 'Neurologist';

	/// en: 'Ophthalmologist'
	String get ophthalmologist => 'Ophthalmologist';

	/// en: 'General Practice'
	String get general => 'General Practice';
}

// Path: adminSettings
class Translations$adminSettings$en {
	Translations$adminSettings$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Admin Profile'
	String get adminProfile => 'Admin Profile';

	/// en: 'Edit super admin details & permissions'
	String get adminProfileDesc => 'Edit super admin details & permissions';

	/// en: 'Change Password'
	String get changePassword => 'Change Password';

	/// en: 'Update master security credentials'
	String get changePasswordDesc => 'Update master security credentials';

	/// en: 'App Information'
	String get appInfo => 'App Information';

	/// en: 'Build version'
	String get appInfoDesc => 'Build version';

	/// en: 'Edit Profile'
	String get editProfileTitle => 'Edit Profile';

	/// en: 'FULL NAME'
	String get fullName => 'FULL NAME';

	/// en: 'EMAIL ADDRESS'
	String get emailAddress => 'EMAIL ADDRESS';

	/// en: 'CLINIC LOCATION'
	String get clinicLocation => 'CLINIC LOCATION';

	/// en: 'Save Changes'
	String get saveChanges => 'Save Changes';

	/// en: 'Tap photo to change'
	String get tapToChangePhoto => 'Tap photo to change';

	/// en: 'Logout'
	String get logout => 'Logout';

	/// en: 'Profile updated successfully!'
	String get updateSuccess => 'Profile updated successfully!';

	/// en: 'Failed to update profile. Please try again.'
	String get updateFailure => 'Failed to update profile. Please try again.';
}

// Path: patientSettings
class Translations$patientSettings$en {
	Translations$patientSettings$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get settingsTitle => 'Settings';

	/// en: 'Account settings'
	String get accountSettings => 'Account settings';

	/// en: 'Change Password'
	String get changePassword => 'Change Password';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'Privacy Policy'
	String get privacyPolicy => 'Privacy Policy';

	/// en: 'More options'
	String get moreOptions => 'More options';

	/// en: 'Languages'
	String get languages => 'Languages';

	/// en: 'Build version'
	String get buildVersion => 'Build version';

	/// en: 'Logout'
	String get logout => 'Logout';

	/// en: 'Log Out'
	String get logoutConfirmationTitle => 'Log Out';

	/// en: 'Are you sure you want to logout?'
	String get logoutConfirmationMessage => 'Are you sure you want to logout?';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Ok'
	String get ok => 'Ok';

	/// en: 'Privacy policy'
	String get privacyPolicyTitle => 'Privacy policy';

	/// en: 'Doctor Hunt Apps Privacy Policy There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words believable. It is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more • The standard chunk of lorem Ipsum used since 1500s is reproduced below for those interested. • Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum. The point of using. • Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted. • The point of using Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted. It is a long established fact that reader distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a moreIt is a long established.'
	String get privacyPolicyContent => 'Doctor Hunt Apps Privacy Policy\n\nThere are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words believable. It is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more\n\n• The standard chunk of lorem Ipsum used since 1500s is reproduced below for those interested.\n\n• Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum. The point of using.\n\n• Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted.\n\n• The point of using Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted.\n\nIt is a long established fact that reader distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a moreIt is a long established.';

	/// en: 'Profile'
	String get profileTitle => 'Profile';

	/// en: 'Personal information'
	String get personalInformation => 'Personal information';

	/// en: 'Name'
	String get nameLabel => 'Name';

	/// en: 'Contact number'
	String get contactNumberLabel => 'Contact number';

	/// en: 'Continue'
	String get continueButton => 'Continue';

	/// en: 'English'
	String get english => 'English';

	/// en: 'Profile updated successfully!'
	String get updateSuccess => 'Profile updated successfully!';

	/// en: 'Failed to update profile. Please try again.'
	String get updateFailure => 'Failed to update profile. Please try again.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.brandName' => 'Doctor Hunt',
			'common.back' => 'Back',
			'onboarding.title1' => 'Find Trusted Doctors',
			'onboarding.title2' => 'Choose Best Doctors',
			'onboarding.title3' => 'Easy Appointments',
			'onboarding.body' => 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.',
			'onboarding.next' => 'Next',
			'onboarding.getStarted' => 'Get Started',
			'onboarding.skip' => 'Skip',
			'chooseRole.title' => 'Choose Your Role',
			'chooseRole.subtitle' => 'Select the role that best describes you to continue!',
			'chooseRole.patient' => 'Patient',
			'chooseRole.patientDescription' => 'Book appointments and manage your medical records.',
			'chooseRole.admin' => 'Admin',
			'chooseRole.adminDescription' => 'Manage doctors, create new doctor profiles, and oversee the platform.',
			'chooseRole.continueButton' => 'Continue',
			'login.welcomeBack' => 'Welcome back',
			'login.joinSubtitle' => 'You can search course, apply course and find\nscholarship for abroad studies',
			'login.forgotPassword' => 'Forgot Password?',
			'login.button' => 'Login',
			'login.dontHaveAccount' => 'Don\'t have an account?',
			'login.joinUs' => 'Join us',
			'login.loginSuccess' => 'Login successful!',
			'signUp.title' => 'Sign Up',
			'signUp.subtitle' => 'Create your account to continue!',
			'signUp.fullNameFieldLabel' => 'Full Name',
			'signUp.fullNameHint' => 'Enter your full name',
			'signUp.phoneFieldLabel' => 'Phone Number',
			'signUp.phoneHint' => 'Enter your phone number',
			'signUp.confirmPasswordFieldLabel' => 'Confirm Password',
			'signUp.confirmPasswordHint' => 'Re-enter your password',
			'signUp.button' => 'Sign Up',
			'signUp.alreadyHaveAccount' => 'Already have an account?',
			'signUp.joinTitle' => 'Join us to start searching',
			'signUp.joinSubtitle' => 'You can search course, apply course and find\nscholarship for abroad studies',
			'signUp.googleLabel' => 'Google',
			'signUp.facebookLabel' => 'Facebook',
			'signUp.nameHint' => 'Name',
			'signUp.emailHint' => 'Email',
			'signUp.passwordHint' => 'Password',
			'signUp.termsAgreement' => 'I agree with the Terms of Service & Privacy Policy',
			'signUp.haveAccount' => 'Have an account?',
			'signUp.logIn' => 'Log in',
			'forgotPassword.sheetTitle' => 'Forgot Password',
			'forgotPassword.sheetBody' => 'Enter your email for the verification process, we will send 4 digits code to your email',
			'forgotPassword.enterCodeSheetTitle' => 'Enter 4 Digits Code',
			'forgotPassword.enterCodeSheetBody' => 'Enter the 4 digits code that you received on your email',
			'forgotPassword.resetPasswordSheetTitle' => 'Reset Password',
			'forgotPassword.resetPasswordSheetBody' => 'Set the new password for your account so you can login and access all the features',
			'forgotPassword.newPasswordHint' => 'New password',
			'forgotPassword.reEnterPasswordHint' => 'Re-enter password',
			'forgotPassword.updatePasswordButton' => 'Update Password',
			'tabs.home' => 'Home',
			'tabs.favourites' => 'Favourites',
			'tabs.appointments' => 'Appointments',
			'tabs.profile' => 'Profile',
			'profile.logout' => 'Logout',
			'profile.createDoctor' => 'Create New Doctor',
			'profile.signOutFailure' => 'Couldn\'t sign you out. Please try again.',
			'favouriteDoctors.title' => 'Favourite Doctors',
			'favouriteDoctors.searchHint' => 'Dentist',
			'favouriteDoctors.drShouey' => 'Dr. Shouey',
			'favouriteDoctors.drChristenfeldN' => 'Dr. Christenfeld N',
			'favouriteDoctors.specalistDentist' => 'Dentist Specialist',
			'favouriteDoctors.specalistMedicine' => 'Medicine Specialist',
			'favouriteDoctors.specalistCardiology' => 'Cardiology Specialist',
			'favouriteDoctors.specalistCancer' => 'Cancer Specialist',
			'favouriteDoctors.featureDoctor' => 'Feature Doctor',
			'favouriteDoctors.statsRunning' => 'Running',
			'favouriteDoctors.statsOngoing' => 'Ongoing',
			'favouriteDoctors.statsPatient' => 'Patient',
			'favouriteDoctors.statsReview' => 'Review',
			'home.greeting' => ({required Object name}) => 'Hi ${name}!',
			'home.userName' => 'Find Your Doctor',
			'home.searchHint' => 'Search.....',
			'home.liveDoctors' => 'Live Doctors',
			'home.popularDoctor' => 'Popular Doctor',
			'home.featureDoctor' => 'Top Rated Doctors',
			'home.seeAll' => 'See all',
			'home.liveBadge' => 'LIVE',
			'home.retry' => 'Retry',
			'doctorData.drBlessing' => 'Dr. Blessing',
			'doctorData.drBlessingSpecialty' => 'Dentist Specialist',
			'doctorData.drFillerupGrab' => 'Dr. Fillerup Grab',
			'doctorData.drFillerupGrabSpecialty' => 'Medicine Specialist',
			'doctorData.drCrick' => 'Dr. Crick',
			'doctorData.drLachinet' => 'Dr. Lachinet',
			'doctorData.drStrain' => 'Dr. Strain',
			'doctorData.priceCrick' => '25.00/ hours',
			'doctorData.priceLachinet' => '29.00/ hours',
			'doctorData.priceStrain' => '22.00/ hours',
			'findDoctors.title' => 'Find Doctors',
			'findDoctors.noResults' => 'No doctors found.',
			'findDoctors.searchHint' => 'Dentist',
			'findDoctors.drShrutiKedia' => 'Dr. Shruti Kedia',
			'findDoctors.drWatamaniuk' => 'Dr. Watamaniuk',
			'findDoctors.drCrownover' => 'Dr. Crownover',
			'findDoctors.drBalestra' => 'Dr. Balestra',
			'findDoctors.toothsDentist' => 'Tooths Dentist',
			'findDoctors.experience7Years' => '7 Years experience',
			'findDoctors.experience9Years' => '9 Years experience',
			'findDoctors.experience5Years' => '5 Years experience',
			'findDoctors.experience6Years' => '6 Years experience',
			'findDoctors.rating87' => '87%',
			'findDoctors.rating74' => '74%',
			'findDoctors.rating59' => '59%',
			'findDoctors.stories69' => '69 Patient Stories',
			'findDoctors.stories78' => '78 Patient Stories',
			'findDoctors.stories86' => '86 Patient Stories',
			'findDoctors.nextAvailable' => 'Next Available',
			'findDoctors.timeTen' => '10:00 AM tomorrow',
			'findDoctors.timeTwelve' => '12:00 AM tomorrow',
			'findDoctors.timeEleven' => '11:00 AM tomorrow',
			'findDoctors.bookNow' => 'Book Now',
			'appointmentBooking.title' => 'Select Time',
			'appointmentBooking.noSlotsAvailable' => 'No slots available',
			'appointmentBooking.slotsAvailable' => 'slots available',
			'appointmentBooking.afternoon' => 'Afternoon',
			'appointmentBooking.evening' => 'Evening',
			'appointmentBooking.morning' => 'Morning',
			'appointmentBooking.confirm' => 'Confirm',
			'appointmentBooking.slots' => 'slots',
			'appointmentBooking.reviewTitle' => 'Review Appointment',
			'appointmentBooking.doctorLabel' => 'Doctor',
			'appointmentBooking.specialtyLabel' => 'Specialty',
			'appointmentBooking.dateTimeLabel' => 'Date & Time',
			'appointmentBooking.feeLabel' => 'Consultation Fee',
			'appointmentBooking.locationLabel' => 'Clinic Location',
			'appointmentBooking.confirmBooking' => 'Confirm Booking',
			'appointmentBooking.selectDateAndTime' => 'Please select a date and time slot',
			'appointmentBooking.successMessage' => ({required Object doctor, required Object date, required Object time}) => 'You booked an appointment with Dr. ${doctor} on ${date}, at ${time}',
			'doctorDetails.title' => 'Doctor Details',
			'doctorDetails.statsRunning' => 'Running',
			'doctorDetails.statsOngoing' => 'Ongoing',
			'doctorDetails.statsPatient' => 'Patient',
			'doctorDetails.servicesTitle' => 'Services',
			'thankYou.title' => 'Thank You!',
			'thankYou.subtitle' => 'Appointment Booked',
			'thankYou.message' => 'Your appointment has been booked successfully. You will receive a confirmation notification shortly.',
			'thankYou.editButton' => 'Edit Appointment',
			'thankYou.doneButton' => 'Done',
			'auth.userNotFound' => 'No account found with this email.',
			'auth.wrongPassword' => 'Incorrect password. Please try again.',
			'auth.emailAlreadyInUse' => 'An account already exists with this email.',
			'auth.weakPassword' => 'Password is too weak. Please use a stronger password.',
			'auth.invalidEmail' => 'Please enter a valid email address.',
			'auth.invalidCredentials' => 'Incorrect email or password. Please try again.',
			'auth.networkRequestFailed' => 'Network error. Please check your connection.',
			'auth.generic' => 'Something went wrong. Please try again.',
			'auth.termsRequired' => 'Please accept the Terms of Service to continue.',
			'auth.emptyFields' => 'Please fill in all fields.',
			'auth.fieldRequired' => 'This field is required.',
			'auth.passwordTooShort' => 'Password must be at least 6 characters.',
			'auth.passwordsMismatch' => 'Passwords do not match.',
			'auth.googleSignInConfig' => 'Google sign-in isn\'t configured. Please check your Firebase settings.',
			'auth.googleSignInError' => 'Google sign-in failed. Please try again.',
			'auth.permissionDenied' => 'You do not have permission to access this resource.',
			'createDoctor.title' => 'Create Doctor',
			'createDoctor.nameLabel' => 'DOCTOR NAME',
			'createDoctor.nameHint' => 'e.g. Dr. Ahmed Ali',
			'createDoctor.specialtyLabel' => 'SPECIALTY',
			'createDoctor.specialtyHint' => 'Select specialty',
			'createDoctor.priceLabel' => 'CONSULTATION FEE',
			'createDoctor.priceHint' => 'e.g. \$28.00',
			'createDoctor.submitButton' => 'Create Doctor',
			'createDoctor.successMessage' => 'Doctor created successfully!',
			'createDoctor.failureMessage' => 'Failed to create doctor. Please try again.',
			'createDoctor.addPhoto' => 'Add photo',
			'createDoctor.changePhoto' => 'Tap photo to change',
			'createDoctor.imageUpload' => 'Doctor Image',
			'createDoctor.imageUploadHint' => 'Upload doctor image',
			'createDoctor.imageUploadTap' => 'Tap to pick an image',
			'editDoctor.title' => 'Edit Doctor',
			'editDoctor.submitButton' => 'Save Changes',
			'editDoctor.successMessage' => 'Doctor updated successfully!',
			'editDoctor.failureMessage' => 'Failed to update doctor. Please try again.',
			'editDoctor.statusLabel' => 'Doctor Status',
			'editDoctor.statusActive' => 'Active & Available',
			'editDoctor.statusInactive' => 'Inactive',
			'editDoctor.deleteDoctor' => 'Delete Doctor',
			'admin.doctorsTitle' => 'Doctors',
			'admin.appointmentsTitle' => 'Appointments',
			'admin.settingsTitle' => 'Settings',
			'admin.searchHint' => 'Search doctors...',
			'admin.totalDoctors' => 'Total Doctors',
			'admin.active' => 'Active',
			'admin.inactive' => 'Inactive',
			'admin.addDoctor' => 'Add Doctor',
			'admin.emptyStateTitle' => 'No doctors yet',
			'admin.emptyStateMessage' => 'Create your first doctor to get started.',
			'admin.retry' => 'Retry',
			'admin.loadFailureMessage' => 'Failed to load doctors. Please try again.',
			'admin.filterTitle' => 'Filter by specialty',
			'admin.filterAll' => 'All',
			'admin.noResultsTitle' => 'No doctors found',
			'admin.noResultsMessage' => 'Try adjusting your search or filters.',
			'admin.editDoctor' => 'Edit Doctor',
			'admin.deleteDoctor' => 'Delete Doctor',
			'admin.deleteTitle' => 'Delete Doctor',
			'admin.deleteMessage' => 'Are you sure you want to delete this doctor? This action cannot be undone.',
			'admin.delete' => 'Delete',
			'admin.cancel' => 'Cancel',
			'admin.deleteFailureMessage' => 'Failed to delete doctor. Please try again.',
			'admin.doctorDetailsTitle' => 'Doctor Details',
			'admin.manageAvailability' => 'Manage Availability',
			'admin.availabilityTitle' => 'Doctor Availability',
			'admin.workingDays' => 'Working Days',
			'admin.daysEnabled' => ({required Object count}) => '${count} days enabled',
			'admin.workingHours' => 'Working Hours',
			'admin.startTime' => 'START TIME',
			'admin.endTime' => 'END TIME',
			'admin.slotDuration' => 'SLOT DURATION',
			'admin.saveAvailability' => 'Save Availability',
			'admin.saveAvailabilitySuccess' => 'Availability updated successfully!',
			'admin.saveAvailabilityFailure' => 'Failed to update availability.',
			'admin.consultationFee' => 'Consultation Fee',
			'admin.rating' => 'Rating',
			'admin.reviewsCount' => ({required Object count}) => '${count} reviews',
			'admin.specialty' => 'Specialty',
			'admin.minutes' => ({required Object count}) => '${count} Minutes',
			'adminAppointments.tabUpcoming' => 'Upcoming',
			'adminAppointments.tabCompleted' => 'Completed',
			'adminAppointments.tabCancelled' => 'Cancelled',
			'adminAppointments.cancelAppointment' => 'Cancel Appointment',
			'adminAppointments.markAsCompleted' => 'Mark as Completed',
			'adminAppointments.viewDetails' => 'View Details',
			'adminAppointments.appointmentDetailsTitle' => 'Appointment Details',
			'adminAppointments.patientSection' => 'Patient',
			'adminAppointments.doctorSection' => 'Doctor',
			'adminAppointments.appointmentSection' => 'Appointment',
			'adminAppointments.clinicLocation' => 'Clinic Location',
			'adminAppointments.emptyState' => 'No appointments found.',
			'adminAppointments.cancelConfirmation' => 'Are you sure you want to cancel this appointment?',
			'adminAppointments.completeConfirmation' => 'Mark this appointment as completed?',
			'patientAppointments.tabUpcoming' => 'Upcoming',
			'patientAppointments.tabCompleted' => 'Completed',
			'patientAppointments.tabCancelled' => 'Cancelled',
			'patientAppointments.cancelAppointment' => 'Cancel Appointment',
			'patientAppointments.rateDoctor' => 'Rate Doctor',
			'patientAppointments.viewDetails' => 'View Details',
			'patientAppointments.tapToRate' => 'Tap to rate your visit',
			'patientAppointments.submitRating' => 'Submit Rating',
			'patientAppointments.reviewComment' => 'Review comment (optional)',
			'patientAppointments.cancelConfirmation' => 'Are you sure you want to cancel this appointment?',
			'patientAppointments.rateSuccess' => 'Thank you for your feedback!',
			'patientAppointments.emptyState' => 'No appointments found.',
			'patientAppointments.yourRating' => 'Your Rating:',
			'patientAppointments.dateLabel' => 'Date',
			'patientAppointments.timeLabel' => 'Time',
			'patientAppointments.feeLabel' => 'Fee',
			'patientAppointments.statusLabel' => 'Status',
			'patientAppointments.ratingLabel' => 'Rating',
			'patientAppointments.clinicLocation' => 'Clinic Location',
			'specialties.cardiologist' => 'Cardiologist',
			'specialties.orthopedic' => 'Orthopedic',
			'specialties.dermatologist' => 'Dermatologist',
			'specialties.pediatrician' => 'Pediatrician',
			'specialties.neurologist' => 'Neurologist',
			'specialties.ophthalmologist' => 'Ophthalmologist',
			'specialties.general' => 'General Practice',
			'adminSettings.adminProfile' => 'Admin Profile',
			'adminSettings.adminProfileDesc' => 'Edit super admin details & permissions',
			'adminSettings.changePassword' => 'Change Password',
			'adminSettings.changePasswordDesc' => 'Update master security credentials',
			'adminSettings.appInfo' => 'App Information',
			'adminSettings.appInfoDesc' => 'Build version',
			'adminSettings.editProfileTitle' => 'Edit Profile',
			'adminSettings.fullName' => 'FULL NAME',
			'adminSettings.emailAddress' => 'EMAIL ADDRESS',
			'adminSettings.clinicLocation' => 'CLINIC LOCATION',
			'adminSettings.saveChanges' => 'Save Changes',
			'adminSettings.tapToChangePhoto' => 'Tap photo to change',
			'adminSettings.logout' => 'Logout',
			'adminSettings.updateSuccess' => 'Profile updated successfully!',
			'adminSettings.updateFailure' => 'Failed to update profile. Please try again.',
			'patientSettings.settingsTitle' => 'Settings',
			'patientSettings.accountSettings' => 'Account settings',
			'patientSettings.changePassword' => 'Change Password',
			'patientSettings.notifications' => 'Notifications',
			'patientSettings.privacyPolicy' => 'Privacy Policy',
			'patientSettings.moreOptions' => 'More options',
			'patientSettings.languages' => 'Languages',
			'patientSettings.buildVersion' => 'Build version',
			'patientSettings.logout' => 'Logout',
			'patientSettings.logoutConfirmationTitle' => 'Log Out',
			'patientSettings.logoutConfirmationMessage' => 'Are you sure you want to logout?',
			'patientSettings.cancel' => 'Cancel',
			'patientSettings.ok' => 'Ok',
			'patientSettings.privacyPolicyTitle' => 'Privacy policy',
			'patientSettings.privacyPolicyContent' => 'Doctor Hunt Apps Privacy Policy\n\nThere are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words believable. It is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more\n\n• The standard chunk of lorem Ipsum used since 1500s is reproduced below for those interested.\n\n• Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum. The point of using.\n\n• Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted.\n\n• The point of using Lorem Ipsum is that it has a moreIt is a long established fact that reader will distracted.\n\nIt is a long established fact that reader distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a moreIt is a long established.',
			'patientSettings.profileTitle' => 'Profile',
			'patientSettings.personalInformation' => 'Personal information',
			'patientSettings.nameLabel' => 'Name',
			'patientSettings.contactNumberLabel' => 'Contact number',
			'patientSettings.continueButton' => 'Continue',
			'patientSettings.english' => 'English',
			'patientSettings.updateSuccess' => 'Profile updated successfully!',
			'patientSettings.updateFailure' => 'Failed to update profile. Please try again.',
			_ => null,
		};
	}
}
