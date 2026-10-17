enum AppointmentStatus { upcoming, completed, cancelled }

class Appointment {
  const Appointment({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.patientPhotoUrl,
    required this.patientEmail,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorPhotoUrl,
    required this.date,
    required this.time,
    required this.fee,
    required this.status,
    required this.clinicLocation,
    this.rating,
    this.reviewComment,
  });

  final String id;
  final String patientId;
  final String patientName;
  final String patientPhotoUrl;
  final String patientEmail;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorPhotoUrl;
  final String date;
  final String time;
  final String fee;
  final AppointmentStatus status;
  final String clinicLocation;
  final double? rating;
  final String? reviewComment;

  factory Appointment.fromJson(String id, Map<String, dynamic> data) {
    return Appointment(
      id: id,
      patientId: data['patientId'] as String? ?? '',
      patientName: data['patientName'] as String? ?? '',
      patientPhotoUrl: data['patientPhotoUrl'] as String? ?? '',
      patientEmail: data['patientEmail'] as String? ?? '',
      doctorId: data['doctorId'] as String? ?? '',
      doctorName: data['doctorName'] as String? ?? '',
      doctorSpecialty: data['doctorSpecialty'] as String? ?? '',
      doctorPhotoUrl: data['doctorPhotoUrl'] as String? ?? '',
      date: data['date'] as String? ?? '',
      time: data['time'] as String? ?? '',
      fee: data['fee'] as String? ?? '',
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => AppointmentStatus.upcoming,
      ),
      clinicLocation: data['clinicLocation'] as String? ?? '',
      rating: (data['rating'] as num?)?.toDouble(),
      reviewComment: data['reviewComment'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'patientName': patientName,
      'patientPhotoUrl': patientPhotoUrl,
      'patientEmail': patientEmail,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorSpecialty': doctorSpecialty,
      'doctorPhotoUrl': doctorPhotoUrl,
      'date': date,
      'time': time,
      'fee': fee,
      'status': status.name,
      'clinicLocation': clinicLocation,
      if (rating != null) 'rating': rating,
      if (reviewComment != null) 'reviewComment': reviewComment,
    };
  }
}
