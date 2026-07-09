import 'package:flutter/material.dart';

import '../../../data/doctor_data.dart';
import '../../../models/doctor_model.dart';
import '../../detail_doctor/detail_doctor_screen.dart';
import '../../all_doctors/all_doctors_screen.dart';

class DoctorSection extends StatelessWidget {
  final String keyword;

  const DoctorSection({
    super.key,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context) {
    final List<DoctorModel> filteredDoctors =
    doctorData.where((doctor) {

  return doctor.name
          .toLowerCase()
          .contains(keyword.toLowerCase()) ||

      doctor.speciality
          .toLowerCase()
          .contains(keyword.toLowerCase());

}).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(
  mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

  children: [

    const Text(
      "Dokter Tersedia",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),

    TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const AllDoctorsScreen(),
          ),
        );
      },

      child: const Text(
        "See All",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

  ],
),

        const SizedBox(height: 20),

        ...filteredDoctors.map(
          (doctor) => Padding(
            padding: const EdgeInsets.only(
              bottom: 18,
            ),
            child: DoctorCard(
              doctor: doctor,
            ),
          ),
        ),

        if (filteredDoctors.isEmpty)
  Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 50,
    ),

    child: Center(
      child: Column(
        children: [

          Container(
            width: 110,
            height: 110,

            decoration: BoxDecoration(
              color: const Color(0xffEAF3FF),
              borderRadius:
                  BorderRadius.circular(55),
            ),

            child: const Icon(
              Icons.search_off_rounded,
              size: 55,
              color: Color(0xff2F80ED),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Dokter tidak ditemukan",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Coba kata kunci lain.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),

        ],
      ),
    ),
  ),

      ],
    );
  }
}

class DoctorCard extends StatefulWidget {
  final DoctorModel doctor;

  const DoctorCard({
    super.key,
    required this.doctor,
  });

  @override
  State<DoctorCard> createState() =>
      _DoctorCardState();
}

class _DoctorCardState
    extends State<DoctorCard> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
        return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailDoctorScreen(
              doctor: widget.doctor,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.12),
              blurRadius: 20,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
  width: 95,
  height: 95,
  decoration: BoxDecoration(
    color: const Color(0xffEAF3FF),
    borderRadius: BorderRadius.circular(40),
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Padding(
      padding: const EdgeInsets.all(2),
      child: Image.asset(
        widget.doctor.image, 
        fit: BoxFit.contain,
      ),
    ),
  ),
),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.doctor.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    widget.doctor.speciality,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
  children: [

    Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [

          const Icon(
            Icons.star,
            size: 15,
            color: Colors.orange,
          ),

          const SizedBox(width: 4),

          Text(
            widget.doctor.rating,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    ),

    const SizedBox(width: 10),

    const Icon(
      Icons.location_on,
      size: 18,
      color: Color(0xff2F80ED),
    ),

    const SizedBox(width: 4),

    Expanded(
      child: Text(
        widget.doctor.location,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Color.fromARGB(255, 158, 158, 158),
        ),
      ),
    ),

  ],
),

                  const SizedBox(height: 12),

                  Text(
                    widget.doctor.price,
                    style: const TextStyle(
                      color: Color(0xff2F80ED),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

           SizedBox(
  width: 90,
  height: 35,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff2F80ED),
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailDoctorScreen(
            doctor: widget.doctor,
          ),
        ),
      );
    },
    child: const Center(
      child: Text(
        "Booking",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}