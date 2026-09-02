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
}

// Path: common
class Translations$common$en {
	Translations$common$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Doctor Hunt'
	String get brandName => 'Doctor Hunt';
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

	/// en: 'Doctor'
	String get doctor => 'Doctor';

	/// en: 'Manage appointments and your schedule as a medical professional.'
	String get doctorDescription => 'Manage appointments and your schedule as a medical professional.';

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

	/// en: 'Chat'
	String get chat => 'Chat';

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

	/// en: 'Feature Doctor'
	String get featureDoctor => 'Feature Doctor';

	/// en: 'See all'
	String get seeAll => 'See all';

	/// en: 'LIVE'
	String get liveBadge => 'LIVE';
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

	/// en: '$ 25.00/ hours'
	String get priceCrick => '\$ 25.00/ hours';

	/// en: '$ 29.00/ hours'
	String get priceLachinet => '\$ 29.00/ hours';

	/// en: '$ 22.00/ hours'
	String get priceStrain => '\$ 22.00/ hours';
}

// Path: findDoctors
class Translations$findDoctors$en {
	Translations$findDoctors$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Find Doctors'
	String get title => 'Find Doctors';

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

	/// en: 'Appointment'
	String get title => 'Appointment';

	/// en: 'Available Time'
	String get availableTime => 'Available Time';

	/// en: 'Reminder Me Before'
	String get reminderMeBefore => 'Reminder Me Before';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: '10:00 AM'
	String get time10am => '10:00 AM';

	/// en: '12:00 AM'
	String get time12am => '12:00 AM';

	/// en: '02:00 PM'
	String get time2pm => '02:00 PM';

	/// en: '03:00 PM'
	String get time3pm => '03:00 PM';

	/// en: '04:00 PM'
	String get time4pm => '04:00 PM';

	/// en: '30'
	String get reminder30 => '30';

	/// en: '40'
	String get reminder40 => '40';

	/// en: '25'
	String get reminder25 => '25';

	/// en: '10'
	String get reminder10 => '10';

	/// en: '35'
	String get reminder35 => '35';

	/// en: 'Minit'
	String get minutes => 'Minit';
}

// Path: doctorDetails
class Translations$doctorDetails$en {
	Translations$doctorDetails$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Doctor Details'
	String get title => 'Doctor Details';

	/// en: 'Dr. Pediatrician'
	String get drPediatrician => 'Dr. Pediatrician';

	/// en: 'Specialist Cardiologist'
	String get specialistCardiologist => 'Specialist Cardiologist';

	/// en: '28.00/hr'
	String get price28PerHour => '28.00/hr';

	/// en: 'Running'
	String get statsRunning => 'Running';

	/// en: 'Ongoing'
	String get statsOngoing => 'Ongoing';

	/// en: 'Patient'
	String get statsPatient => 'Patient';

	/// en: 'Services'
	String get servicesTitle => 'Services';

	/// en: ' Patient care should be the number one priority.'
	String get serviceItem1 => ' Patient care should be the number one priority.';

	/// en: ' If you run your practice you know how frustrating.'
	String get serviceItem2 => ' If you run your practice you know how frustrating.';

	/// en: ' That's why some of appointment reminder system.'
	String get serviceItem3 => ' That\'s why some of appointment reminder system.';
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
			'chooseRole.doctor' => 'Doctor',
			'chooseRole.doctorDescription' => 'Manage appointments and your schedule as a medical professional.',
			'chooseRole.continueButton' => 'Continue',
			'login.welcomeBack' => 'Welcome back',
			'login.joinSubtitle' => 'You can search course, apply course and find\nscholarship for abroad studies',
			'login.forgotPassword' => 'Forgot Password?',
			'login.button' => 'Login',
			'login.dontHaveAccount' => 'Don\'t have an account?',
			'login.joinUs' => 'Join us',
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
			'tabs.chat' => 'Chat',
			'tabs.profile' => 'Profile',
			'profile.logout' => 'Logout',
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
			'home.featureDoctor' => 'Feature Doctor',
			'home.seeAll' => 'See all',
			'home.liveBadge' => 'LIVE',
			'doctorData.drBlessing' => 'Dr. Blessing',
			'doctorData.drBlessingSpecialty' => 'Dentist Specialist',
			'doctorData.drFillerupGrab' => 'Dr. Fillerup Grab',
			'doctorData.drFillerupGrabSpecialty' => 'Medicine Specialist',
			'doctorData.drCrick' => 'Dr. Crick',
			'doctorData.drLachinet' => 'Dr. Lachinet',
			'doctorData.drStrain' => 'Dr. Strain',
			'doctorData.priceCrick' => '\$ 25.00/ hours',
			'doctorData.priceLachinet' => '\$ 29.00/ hours',
			'doctorData.priceStrain' => '\$ 22.00/ hours',
			'findDoctors.title' => 'Find Doctors',
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
			'appointmentBooking.title' => 'Appointment',
			'appointmentBooking.availableTime' => 'Available Time',
			'appointmentBooking.reminderMeBefore' => 'Reminder Me Before',
			'appointmentBooking.confirm' => 'Confirm',
			'appointmentBooking.time10am' => '10:00 AM',
			'appointmentBooking.time12am' => '12:00 AM',
			'appointmentBooking.time2pm' => '02:00 PM',
			'appointmentBooking.time3pm' => '03:00 PM',
			'appointmentBooking.time4pm' => '04:00 PM',
			'appointmentBooking.reminder30' => '30',
			'appointmentBooking.reminder40' => '40',
			'appointmentBooking.reminder25' => '25',
			'appointmentBooking.reminder10' => '10',
			'appointmentBooking.reminder35' => '35',
			'appointmentBooking.minutes' => 'Minit',
			'doctorDetails.title' => 'Doctor Details',
			'doctorDetails.drPediatrician' => 'Dr. Pediatrician',
			'doctorDetails.specialistCardiologist' => 'Specialist Cardiologist',
			'doctorDetails.price28PerHour' => '28.00/hr',
			'doctorDetails.statsRunning' => 'Running',
			'doctorDetails.statsOngoing' => 'Ongoing',
			'doctorDetails.statsPatient' => 'Patient',
			'doctorDetails.servicesTitle' => 'Services',
			'doctorDetails.serviceItem1' => ' Patient care should be the number one priority.',
			'doctorDetails.serviceItem2' => ' If you run your practice you know how frustrating.',
			'doctorDetails.serviceItem3' => ' That\'s why some of appointment reminder system.',
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
			_ => null,
		};
	}
}
