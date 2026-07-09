import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String time;

  NotificationModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.time,
  });
}