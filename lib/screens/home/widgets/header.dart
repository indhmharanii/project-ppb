import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../notification/notification_screen.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
String userName = "Guest";

@override
void initState() {
  super.initState();
  loadUser();
}

Future<void> loadUser() async {
  final prefs = await SharedPreferences.getInstance();

  setState(() {
    userName =
    prefs.getString("currentName") ??
    prefs.getString("name") ??
    "Guest";
  });
}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       SizedBox(
  width: 35,
  child: Builder(
    builder: (context) => IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: const Icon(
        Icons.menu_rounded,
        size: 22,
        color: Colors.black87,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    ),
  ),
),

const SizedBox(width: 10),

        Container(
          width: 58,
          height: 58,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Image.asset(
                "assets/images/profile.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    const Text(
      "Selamat Datang",
      style: TextStyle(
        color: Colors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    const SizedBox(height: 5),

    Text(
      userName,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),

    const SizedBox(height: 5),

        const Text(
      "Temukan dokter terbaik untuk Anda",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
    ),

  ],
),
        ),

        Stack(
          children: [

            Container(
              width: 48,
              height: 48,

              decoration: BoxDecoration(  

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const NotificationScreen(),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.notifications_none_rounded,
                  size: 24,
                ),
              ),
            ),

            Positioned(
              right: 10,
              top: 10,

              child: Container(
                width: 10,
                height: 10,

                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
              ),
            ),

          ],
        ),

      ],
    );
  }
}