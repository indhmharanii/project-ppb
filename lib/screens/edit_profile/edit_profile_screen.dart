import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    nameController.text =
        prefs.getString("name") ?? "Rani";

    emailController.text =
        prefs.getString("email") ?? "rani@gmail.com";
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      "name",
      nameController.text,
    );

    await prefs.setString(
      "email",
      emailController.text,
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
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const CircleAvatar(
              radius: 60,
              backgroundImage:
                  AssetImage("assets/images/profile.png"),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: nameController,

              decoration: InputDecoration(
                hintText: "Full Name",

                prefixIcon: const Icon(
                  Icons.person,
                  color: Color(0xff2F80ED),
                ),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Color(0xff2F80ED),
                    width: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: emailController,

              keyboardType:
                  TextInputType.emailAddress,

              decoration: InputDecoration(
                hintText: "Email Address",

                prefixIcon: const Icon(
                  Icons.email,
                  color: Color(0xff2F80ED),
                ),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(18),
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
              height: 55,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xff2F80ED),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                ),

                onPressed: () async {

  if (nameController.text.isEmpty ||
      emailController.text.isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Semua data wajib diisi."),
      ),
    );

    return;
  }

  await saveProfile();

  if (!mounted) return;

  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Profile berhasil diperbarui."),
    ),
  );

  // ignore: use_build_context_synchronously
  Navigator.pop(context, true);

},

                child: const Text(
                  "SAVE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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