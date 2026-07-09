import 'package:flutter/material.dart';

import '../../models/doctor_model.dart';
import '../booking/booking_screen.dart';

class DetailDoctorScreen extends StatelessWidget {
  final DoctorModel doctor;

  const DetailDoctorScreen({
    super.key,
    required this.doctor,
  });

  Widget infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: const Color(0xff2F80ED),
              size: 28,
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 223, 255),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 202, 223, 255),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Doctor Detail",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            /// FOTO DOKTER
            Container(
              width: 170,
              height: 170,

              decoration: BoxDecoration(
                color: const Color(0xffEAF3FF),
                borderRadius: BorderRadius.circular(35),
              ),

              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  doctor.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Text(
              doctor.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              doctor.speciality,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Row(
                    children: [

                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 18,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        doctor.rating,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(width: 15),

                Row(
                  children: [

                    const Icon(
                      Icons.location_on,
                      color: Color(0xff2F80ED),
                    ),

                    const SizedBox(width: 5),

                    Text(
                      doctor.location,
                    ),

                  ],
                ),

              ],
            ),

            const SizedBox(height: 30),

            Row(
              children: [

                infoCard(
                  icon: Icons.work_history,
                  title: "Experience",
                  value: doctor.experience,
                ),

                const SizedBox(width: 12),

                infoCard(
                  icon: Icons.people,
                  title: "Patients",
                  value: doctor.patients,
                ),

                const SizedBox(width: 12),

                infoCard(
                  icon: Icons.schedule,
                  title: "Schedule",
                  value: doctor.schedule,
                ),

              ],
            ),

            const SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "About Doctor",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Text(
                doctor.about,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: const Color(0xffEAF3FF),
                borderRadius: BorderRadius.circular(18),
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(
                        "Consultation Fee",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        doctor.price,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color(0xff2F80ED),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),

                  SizedBox(
                    width: 150,
                    height: 50,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xff2F80ED),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15),
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
                        "BOOK NOW",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}