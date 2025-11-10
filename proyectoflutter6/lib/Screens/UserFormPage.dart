import 'dart:async';
import 'dart:io';

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

  // Objeto User (fila SQL)
  factory User.fromMap(Map<String, dynamic> map){
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }
}

// Formulario

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();

  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  void loadUsers() async {
    try {
      final value = await DatabaseHelper.instance.getUsers();
      setState(() {
        _users = value.map<User>((e) => User.fromMap(e)).toList();
      });
    } catch (e) {
      print("ERROR$e");
    }
  }

  Future<void> _addUser() async {
    try {
    if(_formKey.currentState!.validate()){
     final newUser = User(name: _nameCtrl.text, email: _emailCtrl.text);
     await DatabaseHelper.instance.insertUser(newUser);
     _nameCtrl.clear();
     _emailCtrl.clear();
  
     // Recargar usuarios desde la DB
     final updatedList = await DatabaseHelper.instance.getUsers();
     setState(() {
       _users = updatedList.map<User>((e) => User.fromMap(e)).toList();
       }); 
     }
   } on Exception catch (e) {
       print("ERROR$e");
     }
  }

  Widget build(BuildContext context) {
    return Container();
  }
}

// Clase auxiliar para manejar SQLite
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("users.db");
    return _database!;
  }
  
  Future<Database?> _initDB(String fileName) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, fileName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  
  Future _onCreate(Database db, int version) async {
    await db.execute(
      ''' CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT,
      email TEXT)
      ''');
  }

  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<List> getUsers() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }
}