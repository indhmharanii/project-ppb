import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../booking/booking_menu_screen.dart';
import '../history/history_screen.dart';
import '../profile/profile_screen.dart';
import '../login/login_screen.dart';

import 'widgets/header.dart';
import 'widgets/search_box.dart';
import 'widgets/category_section.dart';
import 'widgets/doctor_section.dart';
import 'widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {

  final int initialIndex;

  const HomeScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  String keyword = "";
  String userName = "Guest";
  String userEmail = "guest@gmail.com";

  @override
void initState() {
  super.initState();
  currentIndex = widget.initialIndex;
  loadUser();
}
Future<void> loadUser() async {
  final prefs = await SharedPreferences.getInstance();

  setState(() {
    userName =
    prefs.getString("currentName") ??
    prefs.getString("name") ??
    "Guest";

userEmail =
    prefs.getString("currentEmail") ??
    prefs.getString("email") ??
    "guest@gmail.com";
  });
}

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeBody(
        keyword: keyword,
        onSearch: (value) {
          setState(() {
            keyword = value;
          });
        },
      ),

      const BookingMenuScreen(),

      const HistoryScreen(),

      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 223, 255),
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [

      UserAccountsDrawerHeader(
        decoration: const BoxDecoration(
          color: Color(0xff2F80ED),
        ),

        currentAccountPicture: const CircleAvatar(
          backgroundImage: AssetImage(
            "assets/images/profile.png",
          ),
        ),

        accountName: Text(userName),

        accountEmail: Text(userEmail),
      ),

      ListTile(

        leading: const Icon(
          Icons.home,
        ),

        title: const Text(
          "Home",
        ),

        onTap: () {

          Navigator.pop(context);

          setState(() {
            currentIndex = 0;
          });

        },

      ),

      ListTile(

        leading: const Icon(
          Icons.info_outline,
        ),

        title: const Text(
          "About",
        ),

        onTap: () {

          Navigator.pop(context);

          showAboutDialog(

            context: context,

            applicationName: "MediCare",

            applicationVersion: "Version 1.0.0",

            applicationIcon: const Icon(
              Icons.local_hospital,
              color: Color(0xff2F80ED),
              size: 45,
            ),

            children: const [

              SizedBox(height: 10),

              Text(
                "MediCare merupakan aplikasi booking dokter yang membantu pengguna mencari dokter, melakukan booking, serta melihat riwayat konsultasi dengan mudah.",
              ),

              SizedBox(height: 15),

              Text(
                "Developed by Rani",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],

          );

        },

      ),

      const Divider(),

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
              builder: (_) =>
                  const LoginScreen(),
            ),

            (route) => false,

          );

        },

      ),

    ],
  ),
),
      body: pages[currentIndex],

      bottomNavigationBar: BottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  final String keyword;
  final ValueChanged<String> onSearch;

  const HomeBody({
    super.key,
    required this.keyword,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Header(),
            const SizedBox(height: 25),

            const CategorySection(),

          const SizedBox(height: 30),

          SearchBox(
            onChanged: onSearch,
          ),

          const SizedBox(height: 30),

          DoctorSection(
            keyword: keyword,
          ),

                    ],
                  ),
                ),
              );
            }
          }