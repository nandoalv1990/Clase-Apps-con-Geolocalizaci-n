import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper instance = DbHelper._();

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  Future<Database> _initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, "users_db.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          """ CREATE TABLE roles (
          id INTERGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
          ) """
        );
        await db.execute(
          """ CREATE TABLE users(
          id INTERGER PRIMARY KEY AUTOINCREMENT,
          username TEXT NOT NULL,
          password TEXT NOT NULL,
          roleId INTEGER,
          FOREIGN KEY(roleId) REFERENCES roles(id)
          )
        """);
        await db.insert("roles", {"name": "ADMIN"});
        await db.insert("roles", {"name": "USER"});
      },
    );
  }
}