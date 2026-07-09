import 'doctor_model.dart';

class BookingModel {
  final DoctorModel doctor;
  final DateTime date;
  final String time;
  final String status;

  BookingModel({
    required this.doctor,
    required this.date,
    required this.time,
    required this.status,
  });
}