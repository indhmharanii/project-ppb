import 'package:flutter/material.dart';

import '../../data/doctor_data.dart';
import 'booking_screen.dart';

class BookingMenuScreen extends StatelessWidget {
  const BookingMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 223, 255),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 202, 223, 255),
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,

        title: const Column(
          children: [
            Text(
              "Halaman Booking",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3),
            Text(
              "Pilih Dokter yang tersedia",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: doctorData.length,

        itemBuilder: (context, index) {

          final doctor = doctorData[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: Padding(
              padding: const EdgeInsets.all(18),

              child: Row(
                children: [

                  Container(
                    width: 95,
                    height: 95,

                    decoration: BoxDecoration(
                      color: const Color(0xffEAF3FF),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Image.asset(
                        doctor.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                        doctor.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),

                        const SizedBox(height: 5),

                        Text(
                          doctor.speciality,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [

                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 17,
                            ),

                            const SizedBox(width: 4),

                            Text(
                              doctor.rating,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(width: 12),

                            const Icon(
                              Icons.location_on,
                              size: 17,
                              color: Color(0xff2F80ED),
                            ),

                            const SizedBox(width: 4),

                            Expanded(
                              child: Text(
                                doctor.location,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),

                          ],
                        ),

                        const SizedBox(height: 10),

                        Text(
                          doctor.price,
                          style: const TextStyle(
                            color: Color(0xff2F80ED),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                  ),

                  const SizedBox(width: 6),

                  SizedBox(
                    width: 95,
                    height: 40,

                    child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2F80ED),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookingScreen(
                              doctor: doctor,
                            ),
                          ),
                        );

                      },

                     child: const Text(
                      "Booking",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}