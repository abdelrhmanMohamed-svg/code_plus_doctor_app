import '../../../i18n/strings.g.dart';
import '../utils/image_assets.dart';

/// Doctor entity shown on the Doctor Details screen.
class Doctor {
  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    this.price = '',
    this.rating = 0,
    this.photo = defaultPhoto,
    this.isFavorited = false,
    this.isActive = true,
    this.adminId = '',
    this.runningAppointments = 0,
    this.ongoingAppointments = 0,
    this.patients = 0,
    this.services = const [],
  });

  /// Default doctor photo used when no image is uploaded.
  static const String defaultPhoto = ImageAssets.popularDoctor1;

  final String id;
  final String name;
  final String specialty;
  final String price;
  final double rating;
  final String photo;
  final bool isFavorited;
  final bool isActive;
  final String adminId;
  final int runningAppointments;
  final int ongoingAppointments;
  final int patients;
  final List<String> services;

  factory Doctor.fromJson(String id, Map<String, dynamic> data) {
    return Doctor(
      id: id,
      name: data['name'] as String? ?? '',
      specialty: data['specialty'] as String? ?? '',
      price: data['price'] as String? ?? '',
      rating: (data['rating'] as num?)?.toDouble() ?? 0,
      photo: data['photo'] as String? ?? defaultPhoto,
      isFavorited: data['isFavorited'] as bool? ?? false,
      isActive: data['isActive'] as bool? ?? true,
      adminId: data['adminId'] as String? ?? '',
      runningAppointments: data['runningAppointments'] as int? ?? 0,
      ongoingAppointments: data['ongoingAppointments'] as int? ?? 0,
      patients: data['patients'] as int? ?? 0,
      services:
          (data['services'] as List<dynamic>?)?.cast<String>() ?? const [],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'specialty': specialty,
    'price': price,
    'rating': rating,
    'photo': photo,
    'isFavorited': isFavorited,
    'isActive': isActive,
    'adminId': adminId,
    'runningAppointments': runningAppointments,
    'ongoingAppointments': ongoingAppointments,
    'patients': patients,
    'services': services,
  };

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
