import 'package:flutter/material.dart';

import '../login/login_screen.dart';
import '../notification/notification_screen.dart';
import '../edit_profile/edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  String userName = "Rani";
  String userEmail = "rani@gmail.com";

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {

    final prefs =
        await SharedPreferences.getInstance();

    setState(() {

      userName =
          prefs.getString("name") ??
              "Rani";

      userEmail =
          prefs.getString("email") ??
              "rani@gmail.com";

    });

  }

  Widget menuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = const Color(0xff2F80ED),
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.12),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 223, 255),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 202, 223, 255),
        title: const Text(
          "My Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
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

                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage(
                      "assets/images/profile.png",
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    userEmail,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            menuTile(
              icon: Icons.person,
              title: "Edit Profile",
              onTap: () async {

  final result = await Navigator.push(

    context,

    MaterialPageRoute(
      builder: (_) =>
          const EditProfileScreen(),
    ),

  );

  if (result == true) {

    loadProfile();

  }

},
            ),

            menuTile(
              icon: Icons.notifications,
              title: "Notifications",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const NotificationScreen(),
                  ),
                );
              },
            ),

            menuTile(
              icon: Icons.info_outline,
              title: "About Application",
              onTap: () {
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
      "Developed by Team 5",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),

  ],

);
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15),
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
                    fontSize: 16,
                  ),
                ),

                onPressed: () {

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
            ),

            const SizedBox(height: 20),

            const Text(
              "MediCare v1.0.0",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

          ],
        ),
      ),
    );
  }
}