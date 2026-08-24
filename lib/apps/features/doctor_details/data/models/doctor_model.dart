import '../../../../../i18n/strings.g.dart';
import '../../../../core/utils/image_assets.dart';

/// Doctor entity shown on the Doctor Details screen.
class Doctor {
  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.price,
    required this.rating,
    required this.photo,
    required this.isFavorited,
    required this.runningAppointments,
    required this.ongoingAppointments,
    required this.patients,
    required this.services,
  });

  final String id;
  final String name;
  final String specialty;
  final String price;
  final double rating;
  final String photo;
  final bool isFavorited;
  final int runningAppointments;
  final int ongoingAppointments;
  final int patients;
  final List<String> services;

  static final List<Doctor> dummyDoctors = [
    Doctor(
      id: 'dr-pediatrician',
      name: t.doctorDetails.drPediatrician,
      specialty: t.doctorDetails.specialistCardiologist,
      price: t.doctorDetails.price28PerHour,
      rating: 4.5,
      photo: ImageAssets.popularDoctor1,
      isFavorited: true,
      runningAppointments: 100,
      ongoingAppointments: 500,
      patients: 700,
      services: [
        t.doctorDetails.serviceItem1,
        t.doctorDetails.serviceItem2,
        t.doctorDetails.serviceItem3,
      ],
    ),
  ];
}
