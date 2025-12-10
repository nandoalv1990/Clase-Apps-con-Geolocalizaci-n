import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  final AppUser user;
  final auth = AuthService();
  HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home (${user.role})"),
        actions: [
          IconButton(
            onPressed: () async {
              await auth.logout();
              Navigator.pop(context);
            }, 
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: user.role == 'admin'? const Text("Panel de ADMIN") : const Text("Panel de USUARIO"),
      ),
    );
  }
}