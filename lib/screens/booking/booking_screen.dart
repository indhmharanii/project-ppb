import 'package:flutter/material.dart';

import '../../models/doctor_model.dart';
import '../home/home_screen.dart';
import '../../data/notification_data.dart';
import '../../models/notification_model.dart';
import '../../services/booking_service.dart';

final BookingService bookingService = BookingService();
class BookingScreen extends StatefulWidget {
  final DoctorModel doctor;
  
  BookingScreen({
    super.key,
    required this.doctor,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime selectedDate = DateTime.now();

  final TextEditingController patientController =
      TextEditingController();

  final TextEditingController complaintController =
      TextEditingController();

  final List<String> times = [
    "08.00",
    "09.00",
    "10.00",
    "11.00",
    "13.00",
    "14.00",
    "15.00",
    "16.00",
  ];

  int selectedTime = 0;

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: selectedDate,
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 223, 255),

      appBar: AppBar(
        title: const Text("Booking"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
  padding: const EdgeInsets.all(18),

  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(22),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withValues(alpha: 0.10),
        blurRadius: 15,
        offset: const Offset(0, 6),
      ),
    ],
  ),

  child: Row(
    children: [

      Container(
        width: 90,
        height: 90,

        decoration: BoxDecoration(
          color: const Color(0xffEAF3FF),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset(
            widget.doctor.image,
            fit: BoxFit.contain,
          ),
        ),
      ),

      const SizedBox(width: 18),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              widget.doctor.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              widget.doctor.speciality,
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
                  size: 18,
                ),

                const SizedBox(width: 4),

                Text(widget.doctor.rating),

                const SizedBox(width: 12),

                const Icon(
                  Icons.location_on,
                  color: Color(0xff2F80ED),
                  size: 18,
                ),

                const SizedBox(width: 3),

                Expanded(
                  child: Text(
                    widget.doctor.location,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              ],
            ),

          ],
        ),
      ),

    ],
  ),
),

const SizedBox(height: 28),

            const SizedBox(height: 25),
                        const Text(
              "Pilih Tanggal",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 10),

            InkWell(
  borderRadius: BorderRadius.circular(18),
  onTap: pickDate,
  child: Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.10),
          blurRadius: 12,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [

        const CircleAvatar(
          backgroundColor: Color(0xffEAF3FF),
          child: Icon(
            Icons.calendar_today,
            color: Color(0xff2F80ED),
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Text(
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: Colors.grey,
        ),

      ],
    ),
  ),
),
            const SizedBox(height: 25),

            const Text(
              "Pilih Jam",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                times.length,
                (index) => ChoiceChip(
  showCheckmark: false,
  backgroundColor: Colors.white,
  selectedColor: const Color(0xff2F80ED),
  labelStyle: TextStyle(
    color: selectedTime == index
        ? Colors.white
        : Colors.black,
    fontWeight: FontWeight.bold,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
                  label: Text(times[index]),
                  selected: selectedTime == index,
                  onSelected: (_) {
                    setState(() {
                      selectedTime = index;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

           TextField(
  controller: patientController,

  decoration: InputDecoration(
    hintText: "Nama Pasien",

    prefixIcon: const Icon(
      Icons.person,
      color: Color(0xff2F80ED),
    ),

    filled: true,
    fillColor: Colors.white,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide.none,
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide.none,
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(
        color: Color(0xff2F80ED),
        width: 2,
      ),
    ),
  ),
),

            const SizedBox(height: 20),

            TextField(
  controller: complaintController,
  maxLines: 4,

  decoration: InputDecoration(
    hintText: "Keluhan Pasien",

    alignLabelWithHint: true,

    prefixIcon: const Padding(
      padding: EdgeInsets.only(bottom: 65),
      child: Icon(
        Icons.edit_note,
        color: Color(0xff2F80ED),
      ),
    ),

    filled: true,
    fillColor: Colors.white,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide.none,
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide.none,
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(
        color: Color(0xff2F80ED),
        width: 2,
      ),
    ),
  ),
),

            const SizedBox(height: 35),


            SizedBox(
  width: double.infinity,
  height: 58,

  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff2F80ED),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
                onPressed: () async {

  if (patientController.text.trim().isEmpty ||
      complaintController.text.trim().isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Lengkapi nama pasien dan keluhan terlebih dahulu.",
        ),
      ),
    );

    return;
  }

await bookingService.insertBooking(
  doctor: widget.doctor.name,
  speciality: widget.doctor.speciality,
  image: widget.doctor.image,
  location: widget.doctor.location,
  rating: widget.doctor.rating,
  price: widget.doctor.price,
  date: selectedDate.toString(),
  time: times[selectedTime],
  status: "Confirmed",
);
notificationData.insert(
  0,
  NotificationModel(
    title: "Booking Berhasil",

    subtitle:
        "Booking dengan ${widget.doctor.name} berhasil dikonfirmasi.",

    icon: Icons.calendar_month,

    color: Colors.blue,

    time: "Baru saja",
  ),
);

showDialog(
  context: context,
  barrierDismissible: false,
  builder: (_) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),

      content: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [

            Container(
              width: 90,
              height: 90,

              decoration: BoxDecoration(
                color: Colors.green.shade100,
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.check,
                color: Colors.green,
                size: 55,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Booking Sukses",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "janji temu dengan\n${widget.doctor.name}\nberhasil dipesan.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2F80ED),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),

                onPressed: () {

                  Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (_) => const HomeScreen(
      initialIndex: 2,
    ),
  ),
  (route) => false,
);

                },

                child: const Text(
                  "Go To History",
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
    );
  },
);
                },
                child: const Text(
  "Konfirmasi Booking",
  style: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
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