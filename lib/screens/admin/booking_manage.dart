import 'package:flutter/material.dart';
import '../../models/booking_model.dart';
import '../../services/booking_service.dart';
import 'package:intl/intl.dart';

class BookingManageScreen extends StatefulWidget {
  const BookingManageScreen({super.key});

  @override
  State<BookingManageScreen> createState() =>
      _BookingManageScreenState();
}

class _BookingManageScreenState
    extends State<BookingManageScreen> {

  final BookingService bookingService =
      BookingService();

  final TextEditingController searchController =
      TextEditingController();

  String keyword = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 202, 223, 255),

      appBar: AppBar(

        backgroundColor: const Color.fromARGB(255, 202, 223, 255),

        elevation: 0,

        scrolledUnderElevation: 0,

        centerTitle: true,

        title: const Text(

          "Kelola Booking",

          style: TextStyle(

            color: Colors.black,

            fontWeight: FontWeight.bold,

          ),

        ),

      ),

      body: Column(

        children: [

          Padding(

            padding: const EdgeInsets.all(16),

            child: TextField(

              controller: searchController,

              decoration: InputDecoration(

                hintText: "Cari Booking...",

                prefixIcon: const Icon(Icons.search),

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(15),

                  borderSide: BorderSide.none,

                ),

              ),

              onChanged: (value) {

                setState(() {

                  keyword = value.toLowerCase();

                });

              },

            ),

          ),

          Expanded(

            child: StreamBuilder<List<BookingModel>>(
  stream: bookingService.getBookings(),

              builder: (context, snapshot) {

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {

                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                }

                if (!snapshot.hasData ||
                    snapshot.data!.isEmpty) {

                  return const Center(

                    child: Text(
                      "Belum ada booking.",
                    ),

                  );

                }

                List<BookingModel> bookings = snapshot.data!;

if (keyword.isNotEmpty) {
  bookings = bookings.where((booking) {
    return booking.doctor
        .toLowerCase()
        .contains(keyword);
  }).toList();
}

                return ListView.builder(

                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),

                  itemCount: bookings.length,

                  itemBuilder: (context, index) {

                    final booking = bookings[index];
                                        return Card(

                      margin: const EdgeInsets.only(
                        bottom: 16,
                      ),

                      elevation: 2,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),

                      child: Padding(

                        padding: const EdgeInsets.all(16),

                        child: Column(

                          children: [

                            Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    Text(
      booking.doctor,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    const SizedBox(height: 4),

    Text(
      booking.speciality,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 15,
      ),
    ),

    const SizedBox(height: 15),

    Row(
      children: [
        const Icon(
          Icons.person_outline,
          size: 18,
          color: Colors.blue,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "Pasien : ${booking.patient}",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),

    const SizedBox(height: 10),

    Row(
      children: [
        const Icon(
          Icons.medical_information_outlined,
          size: 18,
          color: Colors.orange,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "Keluhan : ${booking.complaint}",
          ),
        ),
      ],
    ),

    const SizedBox(height: 10),

    Row(
      children: [
        const Icon(
          Icons.calendar_today,
          size: 18,
          color: Colors.green,
        ),
        const SizedBox(width: 8),
        Text(
          DateFormat("dd/MM/yyyy")
              .format(DateTime.parse(booking.date)),
        ),
      ],
    ),

    const SizedBox(height: 10),

    Row(
      children: [
        const Icon(
          Icons.access_time,
          size: 18,
          color: Colors.deepPurple,
        ),
        const SizedBox(width: 8),
        Text(booking.time),
      ],
    ),
  ],
),
                            const Divider(),

                            Row(

                              children: [

                                const Text(

                                  "Status",

                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),

                                ),

                                const SizedBox(width: 10),

                                Expanded(

                                  child: DropdownButton<String>(

                                    value: booking.status,

                                    isExpanded: true,

                                    items: const [

                                      DropdownMenuItem(
                                        value: "Pending",
                                        child: Text("Pending"),
                                      ),

                                      DropdownMenuItem(
                                        value: "Confirmed",
                                        child: Text("Confirmed"),
                                      ),

                                      DropdownMenuItem(
                                        value: "Completed",
                                        child: Text("Completed"),
                                      ),

                                    ],

                                    onChanged: (value) async {

                                      if (value == null) {
                                        return;
                                      }

                                      await bookingService
                                          .updateStatus(
                                        booking.id,
                                        value,
                                      );

                                      setState(() {});

                                    },

                                  ),

                                ),

                              ],

                            ),

                            const SizedBox(height: 12),

                            Align(

                              alignment:
                                  Alignment.centerRight,

                              child: TextButton.icon(

                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),

                                label: const Text(

                                  "Hapus",

                                  style: TextStyle(
                                    color: Colors.red,
                                  ),

                                ),

                                onPressed: () async {

                                  final hapus =
                                      await showDialog<bool>(

                                    context: context,

                                    builder: (_) =>
                                        AlertDialog(

                                      title: const Text(
                                          "Hapus Booking"),

                                      content: const Text(
                                          "Yakin ingin menghapus booking ini?"),

                                      actions: [

                                        TextButton(

                                          onPressed: () {

                                            Navigator.pop(
                                                context,
                                                false);

                                          },

                                          child: const Text(
                                              "Batal"),

                                        ),

                                        ElevatedButton(

                                          onPressed: () {

                                            Navigator.pop(
                                                context,
                                                true);

                                          },

                                          child: const Text(
                                              "Hapus"),

                                        ),

                                      ],

                                    ),

                                  );

                                  if (hapus == true) {

                                    await bookingService
                                        .deleteBooking(
                                      booking.id,
                                    );

                                    setState(() {});

                                  }

                                },

                              ),

                            ),
                                                      ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}