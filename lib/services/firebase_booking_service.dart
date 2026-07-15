import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/booking_model.dart';

class FirebaseBookingService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference bookingCollection =
      FirebaseFirestore.instance.collection("bookings");

  // ==========================
  // CREATE
  // ==========================
  Future<void> addBooking(BookingModel booking) async {
    await bookingCollection.add(booking.toMap());
  }

  // ==========================
  // READ (Realtime)
  // ==========================
  Stream<List<BookingModel>> getBookings() {
    return bookingCollection
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return BookingModel.fromFirestore(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    });
  }

  // ==========================
  // UPDATE STATUS
  // ==========================
  Future<void> updateStatus(
    String documentId,
    String status,
  ) async {
    await bookingCollection.doc(documentId).update({
      "status": status,
    });
  }

  // ==========================
  // DELETE
  // ==========================
  Future<void> deleteBooking(
    String documentId,
  ) async {
    await bookingCollection.doc(documentId).delete();
  }

  // ==========================
  // DELETE ALL
  // ==========================
  Future<void> deleteAll() async {
    final snapshot = await bookingCollection.get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}