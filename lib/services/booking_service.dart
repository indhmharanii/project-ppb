import '../models/booking_model.dart';
import 'firebase_booking_service.dart';

class BookingService {
  final FirebaseBookingService firebase =
      FirebaseBookingService();

  // ==========================
  // CREATE
  // ==========================
  Future<void> insertBooking({
    required String patient,
    required String complaint,
    required String doctor,
    required String speciality,
    required String image,
    required String location,
    required String rating,
    required String price,
    required String date,
    required String time,
    required String status,
  }) async {
    final booking = BookingModel(
      id: "",
      patient: patient,
      complaint: complaint,
      doctor: doctor,
      speciality: speciality,
      image: image,
      location: location,
      rating: rating,
      price: price,
      date: date,
      time: time,
      status: status,
    );

    await firebase.addBooking(booking);
  }

  // ==========================
  // READ
  // ==========================
  Stream<List<BookingModel>> getBookings() {
    return firebase.getBookings();
  }

  // ==========================
  // UPDATE
  // ==========================
  Future<void> updateStatus(
    String id,
    String status,
  ) async {
    await firebase.updateStatus(id, status);
  }

  // ==========================
  // DELETE
  // ==========================
  Future<void> deleteBooking(
    String id,
  ) async {
    await firebase.deleteBooking(id);
  }

  // ==========================
  // DELETE ALL
  // ==========================
  Future<void> deleteAllBooking() async {
    await firebase.deleteAll();
  }
}