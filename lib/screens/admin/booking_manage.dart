import 'package:flutter/material.dart';
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

  Future<List<Map<String, dynamic>>> loadBooking() async {

    final data = await bookingService.getBookings();

    if (keyword.isEmpty) {
      return data;
    }

    return data.where((booking) {

      return booking["doctor"]
          .toString()
          .toLowerCase()
          .contains(keyword);

    }).toList();

  }

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

            child: FutureBuilder<List<Map<String, dynamic>>>(

              future: loadBooking(),

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

                final bookings = snapshot.data!;

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

                            ListTile(

                              contentPadding:
                                  EdgeInsets.zero,

                              leading: const CircleAvatar(

                                radius: 25,

                                backgroundColor:
                                    Color(0xff2F80ED),

                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),

                              ),

                              title: Text(

                                booking["doctor"],

                                style: const TextStyle(

                                  fontWeight:
                                      FontWeight.bold,

                                  fontSize: 17,

                                ),

                              ),

                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  const SizedBox(height: 5),

                                  Text(
                                    "Keluhan : ${booking["complaint"]}",
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    "Dokter : ${booking["doctor"]}",
                                  ),

                                  Text(
                                    booking["speciality"],
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                DateFormat("dd/MM/yyyy").format(
                                  DateTime.parse(booking["date"]),
                                ),
                              ),

                                  Text(
                                    booking["time"],
                                  ),

                                ],
                              ),
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

                                    value: booking["status"],

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
                                        booking["id"],
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
                                      booking["id"],
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