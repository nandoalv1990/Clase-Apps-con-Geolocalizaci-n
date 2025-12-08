import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import 'db_helper.dart';

class UserDao {

Future<Database> dbSync() async{
  final db = await DbHelper.instance.database;
  return db;
}

  Future<int> insertUser(User user) async {
    final db = await dbSync();
    return db.insert("users", user.toMap());
  }

  Future<List<User>> getUsers() async{
    final db = await dbSync();
    final res = await db.query("users");
    return res.map((u) => User.fromMap(u)).toList();
  }

  Future<User?> getUserById(int id) async {
    final db = await dbSync();
    final res = await db.query(
      "users",
      where: "id = ?",
      whereArgs: [id],
    );
    if (res.isNotEmpty) return User.fromMap(res.first);
    return null;
  }

  Future<int> updateUser(User user) async {
    final db = await dbSync();
    return db.update(
        "users", 
        user.toMap(),
        where: "id = ?",
        whereArgs: [user.id],
      );
  }

  Future<int> deleteUser(int id) async{
    final db = await dbSync();
    return db.delete(
      "users",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<User>> searchUsers(String text) async {
    final db = await dbSync();
    final res = await db.query(
      "users",
      where: "username LIKE ?",
      whereArgs: ['%$text%'],
    );
    return res.map((u) => User.fromMap(u)).toList();
  }

  Future<int> deleteAll() async {
    final db = await dbSync();
    return db.delete("users");
  }

  Future<List<Map<String, dynamic>>> getUsersWithRoles() async {
    final db = await dbSync();
    return db.rawQuery(
      """  SELECT u.id, u.username, r.name AS role
      FROM users u
      LEF JOIN roles r ON u.roleId = r.id
      """
    ); //final users = await dao.getUsersWithRoles();
  }
}