import 'package:flutter/material.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 223, 255),

      appBar: AppBar(
        title: const Text("Data Pasien"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 202, 223, 255),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),

      body: const Center(
        child: Text(
          "Patient Screen",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}