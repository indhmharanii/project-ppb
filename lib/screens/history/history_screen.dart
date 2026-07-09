import 'package:flutter/material.dart';

import '../../services/booking_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final BookingService bookingService = BookingService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 223, 255),

      appBar: AppBar(
  backgroundColor: const Color.fromARGB(255, 202, 223, 255),
  elevation: 0,
  scrolledUnderElevation: 0,
  centerTitle: true,

  title: const Column(
    children: [
      Text(
        "Booking History",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 3),
      Text(
        "Riwayat Booking Dokter",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 13,
        ),
      ),
    ],
  ),

  actions: [

    IconButton(

      icon: const Icon(
        Icons.delete_outline,
        color: Colors.red,
      ),

      onPressed: () async {

  final result = await showDialog<bool>(

    context: context,

    builder: (_) => AlertDialog(

      title: const Text("Hapus Riwayat"),

      content: const Text(
        "Yakin ingin menghapus seluruh riwayat booking?",
      ),

      actions: [

        TextButton(

          onPressed: () {

            Navigator.pop(context, false);

          },

          child: const Text("Batal"),

        ),

        ElevatedButton(

          onPressed: () {

            Navigator.pop(context, true);

          },

          child: const Text("Hapus"),

        ),

      ],

    ),

  );

  if (result == true) {

    await bookingService.deleteAllBooking();

    setState(() {});

  }

},

    ),

  ],

),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: bookingService.getBookings(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.calendar_month_rounded,
                    size: 90,
                    color: Colors.grey.shade400,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Belum Ada Booking",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Silakan booking dokter terlebih dahulu.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                ],
              ),
            );
          }

          final bookings = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: bookings.length,
            itemBuilder: (context, index) {

              final booking = bookings[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 18),
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Row(
                  children: [

                    Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                        color: const Color(0xffEAF3FF),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          booking["image"],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            booking["doctor"],
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            booking["speciality"],
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            booking["price"],
                            style: const TextStyle(
                              color: Color(0xff2F80ED),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            booking["date"],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),

                          Text(
                            booking["time"],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),

                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        booking["status"],
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}