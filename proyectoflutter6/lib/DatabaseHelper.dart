import 'dart:async';
import 'dart:io';
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

// Clase auxiliar para manejar SQLite
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    try {
     if (_database != null) return _database!;
     } on Exception catch (e) {
      print("ERROR$e");
    }
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