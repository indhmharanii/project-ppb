import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_final_ppb/screens/login/login_screen.dart';

import '../../services/booking_service.dart';
import '../../data/doctor_data.dart';

import 'doctor_manage.dart';
import 'booking_manage.dart';
import 'admin_profile.dart';
import 'admin_notification.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final BookingService bookingService = BookingService();
  String getGreeting() {
  final hour = DateTime.now().hour;

  if (hour < 12) {
    return "Selamat Pagi";
  } else if (hour < 15) {
    return "Selamat Siang";
  } else if (hour < 18) {
    return "Selamat Sore";
  } else {
    return "Selamat Malam";
  }
}
int calculateIncome(List<Map<String, dynamic>> bookings) {

  int total = 0;

  for (var booking in bookings) {

    String price = booking["price"]
        .toString()
        .replaceAll("Rp", "")
        .replaceAll(".", "")
        .replaceAll(",", "")
        .replaceAll(" ", "");

    total += int.tryParse(price) ?? 0;

  }

  return total;

}
String formatIncome(int income) {

  if (income >= 1000) {
    return "Rp${(income / 1000).toStringAsFixed(0)}K";
  }

  return "Rp$income";
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 223, 255),
      drawer: Drawer(

  child: Column(

    children: [

      UserAccountsDrawerHeader(

        accountName: const Text(
          "Admin MediCare",
        ),

        accountEmail: const Text(
          "admin@gmail.com",
        ),

        currentAccountPicture:
            const CircleAvatar(

          backgroundColor: Colors.white,

          child: Icon(
            Icons.admin_panel_settings,
            size: 40,
            color: Color(0xff2F80ED),
          ),

        ),

        decoration: const BoxDecoration(
          color: Color(0xff2F80ED),
        ),

      ),

      ListTile(

        leading: const Icon(Icons.dashboard),

        title: const Text("Dashboard"),

        onTap: () {

          Navigator.pop(context);

        },

      ),

      ListTile(

        leading: const Icon(Icons.local_hospital),

        title: const Text("Kelola Dokter"),

        onTap: () {

  Navigator.pop(context);

  Navigator.push(

    context,

    MaterialPageRoute(

      builder: (_) => const DoctorManageScreen(),

    ),

  );

},
      ),

      ListTile(

        leading: const Icon(Icons.calendar_month),

        title: const Text("Kelola Booking"),

       onTap: () {

  Navigator.pop(context);

  Navigator.push(

    context,

    MaterialPageRoute(

      builder: (_) => const BookingManageScreen(),

    ),

  );

},

      ),

      ListTile(

        leading: const Icon(Icons.person),

        title: const Text("Profile"),

       onTap: () {

  Navigator.pop(context);

  Navigator.push(

    context,

    MaterialPageRoute(

      builder: (_) => const AdminProfileScreen(),

    ),

  );

},

      ),

      const Spacer(),

      ListTile(

        leading: const Icon(
          Icons.logout,
          color: Colors.red,
        ),

        title: const Text(
          "Logout",
          style: TextStyle(
            color: Colors.red,
          ),
        ),

        onTap: () {

         Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (_) => const LoginScreen(),
  ),
  (route) => false,
);

        },

      ),

    ],

  ),

),

      appBar: AppBar(
  backgroundColor: const Color.fromARGB(255, 202, 223, 255),
  elevation: 0,
  scrolledUnderElevation: 0,

  leading: Builder(
    builder: (context) => IconButton(
      icon: const Icon(
        Icons.menu,
        color: Colors.black,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    ),
  ),

  centerTitle: true,

  title: const Text(
    "Dashboard Admin",
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ),

  actions: [

    IconButton(

      onPressed: () {

  Navigator.push(

    context,

    MaterialPageRoute(

      builder: (_) =>
          const AdminNotificationScreen(),

    ),

  );

},

      icon: const Icon(
        Icons.notifications_none,
        color: Colors.black,
      ),

    ),

  ],

),

      body: FutureBuilder<List<Map<String,dynamic>>>(
        future: bookingService.getBookings(),

        builder: (context,snapshot){

          if(snapshot.connectionState ==
              ConnectionState.waiting){

            return const Center(
              child: CircularProgressIndicator(),
            );

          }

          final bookings = snapshot.data ?? [];

          return SingleChildScrollView(

            padding: const EdgeInsets.all(20),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),

  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [

      Text(
        getGreeting(),
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),

      const SizedBox(height: 5),

      const Text(
        "Admin MediCare",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),

    ],
  ),
),

const SizedBox(height: 25),

               GridView.builder(

                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: 4,

                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(

                    crossAxisCount: 2,

                    crossAxisSpacing: 15,

                    mainAxisSpacing: 15,

                    childAspectRatio: 1.4,

                  ),

                  itemBuilder: (context, index) {

                    final data = [
                     {
                        "icon": Icons.local_hospital,
                        "title": "Total Dokter",
                        "value": doctorData.length.toString(),
                        "color": Colors.blue,
                      },

                      {
                        "icon": Icons.calendar_month,
                        "title": "Booking Hari Ini",
                        "value": bookings.length.toString(),
                        "color": Colors.green,
                      },

                      {
                        "icon": Icons.people,
                        "title": "Total Pasien",
                        "value": bookings.length.toString(),
                        "color": Colors.orange,
                      },

                      {
                        "icon": Icons.payments,
                        "title": "Pendapatan",
                        "value": formatIncome(
                            calculateIncome(bookings)),
                        "color": Colors.purple,
                      },
                    ];

    return dashboardCard(
  icon: data[index]["icon"] as IconData,
  iconColor: data[index]["color"] as Color,
  bgColor: (data[index]["color"] as Color).withValues(alpha: 0.15),
  title: data[index]["title"].toString(),
  value: data[index]["value"].toString(),
);

  },

),

                const SizedBox(height:30),

                Row(

                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children:[

                    const Text(

                      "Booking Terbaru",

                      style: TextStyle(

                        fontSize:22,

                        fontWeight: FontWeight.bold,

                      ),

                    ),

                  ],

                ),

                const SizedBox(height:15),
                if(bookings.isEmpty)

  Container(

    width: double.infinity,

    padding: const EdgeInsets.symmetric(
      vertical: 60,
    ),

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),

    child: const Column(

      children: [

        Icon(
          Icons.calendar_month,
          size: 60,
          color: Colors.grey,
        ),

        SizedBox(height: 15),

        Text(
          "Belum ada booking",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

      ],

    ),

  )

else

  ListView.builder(

    shrinkWrap: true,

    physics:
        const NeverScrollableScrollPhysics(),

    itemCount: bookings.length,

    itemBuilder: (context,index){

      final booking = bookings[index];

      final tanggal = DateFormat(
        "dd MMM yyyy",
      ).format(
        DateTime.parse(
          booking["date"],
        ),
      );

      return Container(

        margin: const EdgeInsets.only(
          bottom: 15,
        ),

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(18),

          boxShadow: [

            BoxShadow(

              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.08),

              blurRadius: 12,

              offset: const Offset(0,5),

            ),

          ],

        ),

        child: Row(

          children: [

           CircleAvatar(
  radius: 30,
  backgroundColor: const Color(0xffEAF3FF),

  child: ClipOval(

    child: Image.asset(

      booking["image"],

      width: 70,

      height: 70,

      fit: BoxFit.contain,

    ),

  ),

),

            const SizedBox(width:15),

            Expanded(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
  booking["patient"] ?? "-",
  style: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 4),

Text(
  "Keluhan : ${booking["complaint"]}",
  style: const TextStyle(
    color: Colors.black87,
    fontSize: 13,
  ),
),

const SizedBox(height: 6),
Text(
  booking["doctor"],
  style: const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
  ),
),
                  const SizedBox(height:3),

                  Text(

                    booking["speciality"],

                    style: const TextStyle(

                      color: Colors.grey,

                      fontSize:12,

                    ),

                  ),

                  const SizedBox(height:8),

                  Row(

                    children: [

                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey,
                      ),

                      const SizedBox(width:5),

                      Text(
                        tanggal,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),

                    ],

                  ),

                  const SizedBox(height:4),

                  Row(

                    children: [

                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey,
                      ),

                      const SizedBox(width:5),

                      Text(
                        booking["time"],
                        style: const TextStyle(
                          fontSize:12,
                        ),
                      ),

                    ],

                  ),

                ],

              ),

            ),

            Container(

              padding:
                  const EdgeInsets.symmetric(

                horizontal:12,

                vertical:6,

              ),

              decoration: BoxDecoration(

                color:
    booking["status"] == "Pending"
        ? Colors.orange.shade100
        : booking["status"] == "Completed"
            ? Colors.blue.shade100
            : Colors.green.shade100,

                borderRadius:
                    BorderRadius.circular(20),

              ),

              child: Text(

                booking["status"],

               style: TextStyle(

  color:
      booking["status"] == "Pending"
          ? Colors.orange
          : booking["status"] == "Completed"
              ? Colors.blue
              : Colors.green,

  fontSize: 11,

  fontWeight: FontWeight.bold,

),

              ),

            ),

          ],

        ),

      );

    },

  ),

const SizedBox(height:25),

Center(

  child: SizedBox(

    width: 260,

    height: 50,

    child: ElevatedButton.icon(

      style: ElevatedButton.styleFrom(

        backgroundColor: Colors.red,

        shape: RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(14),

        ),

      ),

      onPressed: () async {

        await bookingService.deleteAllBooking();

        setState(() {});

      },

      icon: const Icon(
        Icons.delete_forever,
        color: Colors.white,
      ),

      label: const Text(

        "Hapus Semua Booking",

        style: TextStyle(

          color: Colors.white,

          fontWeight: FontWeight.bold,

        ),

      ),

    ),

  ),

),

],
),
);
},
),
);
}
Widget dashboardCard({
  required IconData icon,
  required Color iconColor,
  required Color bgColor,
  required String title,
  required String value,
}) {
  return Container(
    padding: const EdgeInsets.all(16),

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),

    child: Row(
      children: [

        CircleAvatar(
          radius: 22,
          backgroundColor: bgColor,
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

            ],
          ),
        ),

      ],
    ),
  );
}
}