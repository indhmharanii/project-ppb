import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;
  final String patient;
  final String complaint;
  final String doctor;
  final String speciality;
  final String image;
  final String location;
  final String rating;
  final String price;
  final String date;
  final String time;
  final String status;

  BookingModel({
    required this.id,
    required this.patient,
    required this.complaint,
    required this.doctor,
    required this.speciality,
    required this.image,
    required this.location,
    required this.rating,
    required this.price,
    required this.date,
    required this.time,
    required this.status,
  });

  factory BookingModel.fromFirestore(
    String id,
    Map<String, dynamic> data,
  ) {
    return BookingModel(
      id: id,
      patient: data["patient"] ?? "",
      complaint: data["complaint"] ?? "",
      doctor: data["doctor"] ?? "",
      speciality: data["speciality"] ?? "",
      image: data["image"] ?? "",
      location: data["location"] ?? "",
      rating: data["rating"] ?? "",
      price: data["price"] ?? "",
      date: data["date"] ?? "",
      time: data["time"] ?? "",
      status: data["status"] ?? "Pending",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "patient": patient,
      "complaint": complaint,
      "doctor": doctor,
      "speciality": speciality,
      "image": image,
      "location": location,
      "rating": rating,
      "price": price,
      "date": date,
      "time": time,
      "status": status,
      "createdAt": FieldValue.serverTimestamp(),
    };
  }
}