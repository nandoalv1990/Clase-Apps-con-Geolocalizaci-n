//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final auth = AuthService();
  final userService = UserService();

  Future<void> login() async {
    try {
      await auth.login(emailCtrl.text, passCtrl.text);
      final user = await userService.getUser(auth.currentUser!.uid);
      Navigator.pushReplacement (
        context, 
        MaterialPageRoute(
          builder: (_) => HomeScreen(user: user),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error al iniciar sesión")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio de sesión"),),
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: emailCtrl, 
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: passCtrl, 
            decoration: const InputDecoration(labelText: "Contraseña"),
          ),
          const SizedBox(height: 16.0,),

          ElevatedButton(
            onPressed: login, 
            child: const Text("Iniciar sesión")
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RegisterScreen()),
            ), child: const Text("Crear cuenta"),
          )
        ],
      ),
     ),
    );
  }
}
