import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscure = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 180, 212, 255),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Daftar Akun",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 20),

              Center(
                child: Container(
                  width: 95,
                  height: 95,
                  decoration: BoxDecoration(
                    color: const Color(0xff2F80ED),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.person_add_alt_1,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Center(
                child: Text(
                  "Buat Akun Baru",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  "Daftar untuk menggunakan MediCare",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Nama Lengkap",
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passwordController,
                obscureText: obscure,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),

                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    icon: Icon(
                      obscure
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                 onPressed: () async {

  String name = nameController.text.trim();
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  // Nama kosong
  if (name.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Nama tidak boleh kosong"),
      ),
    );
    return;
  }

  // Email kosong
  if (email.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Email tidak boleh kosong"),
      ),
    );
    return;
  }

  // Format email
  if (!email.contains("@") || !email.contains(".")) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Masukkan email yang valid"),
      ),
    );
    return;
  }

  // Password kosong
  if (password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password tidak boleh kosong"),
      ),
    );
    return;
  }

  // Password minimal
  if (password.length < 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password minimal 6 karakter"),
      ),
    );
    return;
  }

  final prefs = await SharedPreferences.getInstance();

  await prefs.setString("name", name);
  await prefs.setString("email", email);
  await prefs.setString("password", password);

  if (!mounted) return;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      title: const Text("Registrasi Berhasil 🎉"),

      content: const Text(
        "Akun berhasil dibuat.\nSilakan login menggunakan akun yang baru didaftarkan.",
      ),

      actions: [

        TextButton(
          onPressed: () {

            Navigator.pop(context);

            Navigator.pop(context);

          },

          child: const Text("Login"),
        ),

      ],
    ),
  );

},

                  child: const Text(
                    "DAFTAR",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text(
                    "Sudah punya akun?",
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                    ),
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}