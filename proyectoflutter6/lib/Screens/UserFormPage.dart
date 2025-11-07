import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//Modelo simple de usuario
class User{
  final int? id;
  final String name;
  final String email;

  User(
    {this.id, required this.name, required this.email}
  );

  // Mapa para SQL
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name' : name,
      'email' : email,
    };
  }
}

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}