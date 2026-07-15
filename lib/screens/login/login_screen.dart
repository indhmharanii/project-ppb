import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/auth_service.dart';
import '../home/home_screen.dart';
import '../register/register_screen.dart';
import '../admin/admin_home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
final passwordController = TextEditingController();

final AuthService authService = AuthService();

bool obscure = true;
bool remember = false;
bool loading = false;

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

   onPressed: loading
    ? null
    : () async {
        String email = emailController.text.trim();
        String password = passwordController.text.trim();

        if (email.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Email tidak boleh kosong"),
            ),
          );
          return;
        }

        if (!email.contains("@") || !email.contains(".")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Masukkan email yang valid"),
            ),
          );
          return;
        }

        if (password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password tidak boleh kosong"),
            ),
          );
          return;
        }

        if (password.length < 6) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password minimal 6 karakter"),
            ),
          );
          return;
        }

        setState(() {
          loading = true;
        });

        try {
          // LOGIN ADMIN
          if (email == "admin@gmail.com" &&
              password == "admin123") {
            if (!mounted) return;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const AdminHome(),
              ),
            );
            return;
          }

          // LOGIN USER FIREBASE
          await authService.login(
            email: email,
            password: password,
          );

          if (!mounted) return;

          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );
        } on FirebaseAuthException catch (e) {
          String pesan = "Login gagal";

          if (e.code == "user-not-found") {
            pesan = "Email tidak ditemukan";
          } else if (e.code == "wrong-password") {
            pesan = "Password salah";
          } else if (e.code == "invalid-credential") {
            pesan = "Email atau password salah";
          } else if (e.code == "invalid-email") {
            pesan = "Format email tidak valid";
          }

          if (!mounted) return;

          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(pesan),
            ),
          );
        } finally {
          if (mounted) {
            setState(() {
              loading = false;
            });
          }
        }
      },

    child: loading
    ? const SizedBox(
        height: 22,
        width: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      )
    : const Text("LOGIN"),

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