/// Doctor entity shown on the Doctor Details screen.
class Doctor {
  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    this.price = '',
    this.rating = 2,
    this.reviewsCount = 0,
    required this.photo,
    this.isFavorited = false,
    this.isActive = true,
    this.adminId = '',
    this.runningAppointments = 0,
    this.ongoingAppointments = 0,
    this.patients = 0,
    this.services = const [],
    this.workingDays = const [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
    ],
    this.startTime = '09:00 AM',
    this.endTime = '05:00 PM',
    this.slotDuration = 30,
  });

  /// Photo URL from Cloudinary.

  final String id;
  final String name;
  final String specialty;
  final String price;
  final double rating;
  final int reviewsCount;
  final String photo;
  final bool isFavorited;
  final bool isActive;
  final String adminId;
  final int runningAppointments;
  final int ongoingAppointments;
  final int patients;
  final List<String> services;
  final List<String> workingDays;
  final String startTime;
  final String endTime;
  final int slotDuration;

  factory Doctor.fromJson(String id, Map<String, dynamic> data) {
    return Doctor(
      id: id,
      name: data['name'] as String? ?? '',
      specialty: data['specialty'] as String? ?? '',
      price: data['price'] as String? ?? '',
      rating: (data['rating'] as num?)?.toDouble() ?? 2,
      reviewsCount: (data['reviewsCount'] as num?)?.toInt() ?? 0,
      photo: data['photo'] as String? ?? '',
      isFavorited: data['isFavorited'] as bool? ?? false,
      isActive: data['isActive'] as bool? ?? true,
      adminId: data['adminId'] as String? ?? '',
      runningAppointments: data['runningAppointments'] as int? ?? 0,
      ongoingAppointments: data['ongoingAppointments'] as int? ?? 0,
      patients: data['patients'] as int? ?? 0,
      services:
          (data['services'] as List<dynamic>?)?.cast<String>() ?? const [],
      workingDays:
          (data['workingDays'] as List<dynamic>?)?.cast<String>() ??
          const ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
      startTime: data['startTime'] as String? ?? '09:00 AM',
      endTime: data['endTime'] as String? ?? '05:00 PM',
      slotDuration: data['slotDuration'] as int? ?? 30,
    );
  }

  Doctor copyWith({
    String? id,
    String? name,
    String? specialty,
    String? price,
    double? rating,
    int? reviewsCount,
    String? photo,
    bool? isFavorited,
    bool? isActive,
    String? adminId,
    int? runningAppointments,
    int? ongoingAppointments,
    int? patients,
    List<String>? services,
    List<String>? workingDays,
    String? startTime,
    String? endTime,
    int? slotDuration,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      photo: photo ?? this.photo,
      isFavorited: isFavorited ?? this.isFavorited,
      isActive: isActive ?? this.isActive,
      adminId: adminId ?? this.adminId,
      runningAppointments: runningAppointments ?? this.runningAppointments,
      ongoingAppointments: ongoingAppointments ?? this.ongoingAppointments,
      patients: patients ?? this.patients,
      services: services ?? this.services,
      workingDays: workingDays ?? this.workingDays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      slotDuration: slotDuration ?? this.slotDuration,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'specialty': specialty,
    'price': price,
    'rating': rating,
    'reviewsCount': reviewsCount,
    'photo': photo,
    'isFavorited': isFavorited,
    'isActive': isActive,
    'adminId': adminId,
    'runningAppointments': runningAppointments,
    'ongoingAppointments': ongoingAppointments,
    'patients': patients,
    'services': services,
    'workingDays': workingDays,
    'startTime': startTime,
    'endTime': endTime,
    'slotDuration': slotDuration,
  };
}
