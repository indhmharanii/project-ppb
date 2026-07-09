import 'package:flutter/material.dart';
import '../../data/notification_data.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF3FA),

      appBar: AppBar(
        backgroundColor: const Color(0xffEEF3FA),
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: const Column(
          children: [
            Text(
              "Notifications",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Latest updates",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),

     body: notificationData.isEmpty
    ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.notifications_off_outlined,
              size: 80,
              color: Colors.grey,
            ),

            SizedBox(height: 20),

            Text(
              "Belum ada notifikasi",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Notifikasi booking akan muncul di sini.",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

          ],
        ),
      )
    : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: notificationData.length,

        itemBuilder: (context, index) {

          final notification = notificationData[index];

          return notificationCard(
            icon: notification.icon,
            color: notification.color,
            title: notification.title,
            subtitle: notification.subtitle,
            time: notification.time,
          );

        },
      ),
    );
  }

  Widget notificationCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),

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

      child: ListTile(
        contentPadding: const EdgeInsets.all(16),

        leading: CircleAvatar(
          radius: 26,
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            subtitle,
            style: const TextStyle(
              height: 1.4,
            ),
          ),
        ),

        trailing: Text(
          time,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}