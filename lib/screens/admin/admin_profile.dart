import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login_screen.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() =>
      _AdminProfileScreenState();
}

class _AdminProfileScreenState
    extends State<AdminProfileScreen> {

  String name = "Administrator";
  String email = "admin@gmail.com";

  @override
  void initState() {
    super.initState();
    loadAdmin();
  }

  Future<void> loadAdmin() async {

    final prefs =
        await SharedPreferences.getInstance();

    setState(() {

      name = prefs.getString("name") ??
          "Administrator";

      email = prefs.getString("email") ??
          "admin@gmail.com";

    });

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

          "Profile Admin",

          style: TextStyle(

            color: Colors.black,

            fontWeight: FontWeight.bold,

          ),

        ),

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [
            Center(
  child: CircleAvatar(
    radius: 60,
    backgroundColor: const Color(0xff2F80ED),
    child: const Icon(
      Icons.admin_panel_settings,
      size: 65,
      color: Colors.white,
    ),
  ),
),

const SizedBox(height: 20),

Text(
  name,
  style: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 5),

Text(
  email,
  style: const TextStyle(
    color: Colors.grey,
    fontSize: 15,
  ),
),

const SizedBox(height: 30),

Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 10,
      ),
    ],
  ),

  child: Column(
    children: [

      ListTile(
        leading: const Icon(
          Icons.person,
          color: Color(0xff2F80ED),
        ),
        title: const Text("Nama"),
        subtitle: Text(name),
      ),

      const Divider(height: 1),

      ListTile(
        leading: const Icon(
          Icons.email,
          color: Color(0xff2F80ED),
        ),
        title: const Text("Email"),
        subtitle: Text(email),
      ),

      const Divider(height: 1),

      const ListTile(
        leading: Icon(
          Icons.verified_user,
          color: Color(0xff2F80ED),
        ),
        title: Text("Role"),
        subtitle: Text("Administrator"),
      ),

      const Divider(height: 1),

      const ListTile(
        leading: Icon(
          Icons.local_hospital,
          color: Color(0xff2F80ED),
        ),
        title: Text("Aplikasi"),
        subtitle: Text("MediCare v1.0"),
      ),

    ],
  ),
),

const SizedBox(height: 35),

SizedBox(
  width: double.infinity,
  height: 55,

  child: ElevatedButton.icon(

    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),

    icon: const Icon(
      Icons.logout,
      color: Colors.white,
    ),

    label: const Text(
      "Logout",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),

    onPressed: () {

      Navigator.pushAndRemoveUntil(

        context,

        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),

        (route) => false,

      );

    },

  ),

),
          ],
        ),
      ),
    );
  }
}