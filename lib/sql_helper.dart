import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE Items(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   Email TEXT,
   password TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }

  static Future<Database> db() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'demo.db');
    return openDatabase(path, version: 1, onCreate: (Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<int> createItem(String Email, String password) async {
    final db = await SQLHelper.db();
    final data = {'Email': Email, 'password': password};
    final id = await db.insert('Items', data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('Items', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItemById(int id) async {
    final db = await SQLHelper.db();
    return db.query('Items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String Email, String password) async {
    final db = await SQLHelper.db();
    final data = {'Email': Email, 'password': password, 'createdAt': DateTime.now().toString()};
    final result = await db.update('Items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("Items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
