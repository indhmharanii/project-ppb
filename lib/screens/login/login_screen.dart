import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../register/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscure = true;
  bool remember = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 180, 212, 255),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 40),

Center(
  child: SizedBox(
  width: 120,
  height: 120,
  child: Image.asset(
    "assets/images/logo.png",
    fit: BoxFit.contain,
  ),
),
),

const SizedBox(height: 30),

const Center(
  child: Text(
    "Welcome Back",
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 8),

const Center(
  child: Text(
    "Login untuk melanjutkan",
    style: TextStyle(
      color: Colors.grey,
    ),
  ),
),

const SizedBox(height: 45),
TextField(
  controller: emailController,

  decoration: const InputDecoration(
    labelText: "Email",

    prefixIcon: Icon(
      Icons.email_outlined,
    ),
  ),
),
const SizedBox(height:20),

TextField(

  controller: passwordController,

  obscureText: obscure,

  decoration: InputDecoration(

    labelText: "Password",

    prefixIcon: const Icon(
      Icons.lock_outline,
    ),

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

const SizedBox(height:25),

SizedBox(

  width: double.infinity,

  child: ElevatedButton(

    onPressed: () async {

  String email = emailController.text.trim();
  String password = passwordController.text.trim();

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

  final savedEmail =
      prefs.getString("email") ?? "";

  final savedPassword =
      prefs.getString("password") ?? "";

  if (!mounted) return;

  if (email == savedEmail &&
      password == savedPassword) {
        final savedName =
    prefs.getString("name") ?? "Guest";

await prefs.setString(
  "currentName",
  savedName,
);

await prefs.setString(
  "currentEmail",
  savedEmail,
);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );

  } else {

    showDialog(
      context: context,
      builder: (_) => AlertDialog(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),

        title: const Text(
          "Login Gagal",
        ),

        content: const Text(
          "Email atau password salah.",
        ),

        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),

        ],
      ),
    );

  }

},

    child: const Text(
      "LOGIN",
    ),

  ),

),
const SizedBox(height:25),

Row(

  mainAxisAlignment: MainAxisAlignment.center,

  children: [

    const Text(
      "Belum punya akun?",
    ),

    TextButton(

      onPressed: (){

        Navigator.push(

          context,

          MaterialPageRoute(

            builder: (_)=>const RegisterScreen(),

          ),

        );

      },

      child: const Text(
        "Daftar",
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