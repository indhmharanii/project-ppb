import 'package:flutter/material.dart';

import '../../data/doctor_data.dart';
import '../detail_doctor/detail_doctor_screen.dart';

class AllDoctorsScreen extends StatelessWidget {
  const AllDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF3FA),

      appBar: AppBar(
        backgroundColor: const Color(0xffEEF3FA),
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: const Text(
          "All Doctors",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: doctorData.length,
        itemBuilder: (context, index) {
          final doctor = doctorData[index];

          return InkWell(
            borderRadius: BorderRadius.circular(22),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailDoctorScreen(
                    doctor: doctor,
                  ),
                ),
              );
            },

            child: Container(
              margin: const EdgeInsets.only(bottom: 18),

              padding: const EdgeInsets.all(16),

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

              child: Row(
                children: [

                  Container(
                    width: 80,
                    height: 80,

                    decoration: BoxDecoration(
                      color: const Color(0xffEAF3FF),
                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        doctor.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          doctor.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          doctor.speciality,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [

                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),

                            const SizedBox(width: 4),

                            Text(
                              doctor.rating,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(width: 15),

                            const Icon(
                              Icons.location_on,
                              color: Color(0xff2F80ED),
                              size: 16,
                            ),

                            const SizedBox(width: 4),

                            Expanded(
                              child: Text(
                                doctor.location,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                          ],
                        ),

                        const SizedBox(height: 10),

                        Text(
                          doctor.price,
                          style: const TextStyle(
                            color: Color(0xff2F80ED),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                      ],
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