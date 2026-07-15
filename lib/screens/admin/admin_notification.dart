import 'package:flutter/material.dart';

import '../../services/booking_service.dart';
import '../../models/booking_model.dart';

class AdminNotificationScreen extends StatefulWidget {
  const AdminNotificationScreen({super.key});

  @override
  State<AdminNotificationScreen> createState() =>
      _AdminNotificationScreenState();
}

class _AdminNotificationScreenState
    extends State<AdminNotificationScreen> {

  final BookingService bookingService =
      BookingService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 202, 223, 255),

      appBar: AppBar(

        title: const Text("Notifikasi"),

        centerTitle: true,

        backgroundColor: const Color.fromARGB(255, 202, 223, 255),

        elevation: 0,

      ),

      body: StreamBuilder<List<BookingModel>>(

        stream: bookingService.getBookings(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return const Center(
              child: CircularProgressIndicator(),
            );

          }

          final List<BookingModel> bookings = snapshot.data!;

          if (bookings.isEmpty) {

            return const Center(

              child: Text(
                "Belum ada notifikasi.",
              ),

            );

          }

          return ListView.builder(

            padding: const EdgeInsets.all(16),

            itemCount: bookings.length,

            itemBuilder: (context, index) {

              BookingModel booking = bookings[index];

              return Card(

                margin:
                    const EdgeInsets.only(bottom: 15),

                child: ListTile(

                  leading: CircleAvatar(

                    backgroundColor:
                        Colors.blue.shade100,

                    child: const Icon(

                      Icons.notifications,

                      color: Color(0xff2F80ED),

                    ),

                  ),

                  title: Text(

                    booking.doctor,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),

                  ),

                  subtitle: Text(

                    "${booking.date}\n${booking.time}",

                  ),

                  trailing: Container(

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 10,

                      vertical: 5,

                    ),

                    decoration: BoxDecoration(

                      color: Colors.green.shade100,

                      borderRadius:
                          BorderRadius.circular(20),

                    ),

                    child: Text(

                      booking.status,

                      style: const TextStyle(

                        color: Colors.green,

                        fontWeight: FontWeight.bold,

                      ),

                    ),

                  ),

                ),

              );

            },

          );

        },

      ),

    );

  }

}