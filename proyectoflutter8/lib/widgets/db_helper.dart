import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  Database? _database;

  Future<Database> get database async => _database ??= await initDB();
  
  Future<Database> initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, "rutas.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE puntos(
            id INTERGER PRIMARY KEY AUTOINCREMENT,
            lat REAL,
            lng REAL
          )
        """);
      }
    );
  }
  Future<int> insertPunto(Map<String, dynamic> data) async {
    final db = await database;
    return db.insert("puntos", data);
  }
  Future<List<Map<String, dynamic>>> getPuntos() async {
    final db = await database;
    return db.query("puntos");
  }
}