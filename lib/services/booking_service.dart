import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';

class BookingService {
  Future<int> insertBooking({
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

  final db = await DatabaseHelper.database;

  return db.insert(
    "booking",
    {
      "doctor": doctor,
      "speciality": speciality,
      "image": image,
      "location": location,
      "rating": rating,
      "price": price,
      "date": date,
      "time": time,
      "status": status,
    },
  );
}

  Future<List<Map<String, dynamic>>> getBookings() async {
    final Database db = await DatabaseHelper.database;

    return await db.query(
      "booking",
      orderBy: "id DESC",
    );
  }

  Future<void> deleteAllBooking() async {
    final Database db = await DatabaseHelper.database;

    await db.delete("booking");
  }
}