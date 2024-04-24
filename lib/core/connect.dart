import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Connect {
  static Database? _database;

  static Future<Database?> get database async {
    return _database;
  }

  static Future<void> initialize() async {
    String path = inMemoryDatabasePath;

    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
      path = await getDatabasesPath();
    }

    bool exists = await databaseExists(path);

    if (!exists) {
      _database =
          await openDatabase(path, version: 1, onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nickname TEXT,
            password TEXT,
            avatar TEXT
          )
        ''');

        await db.execute('''
        CREATE TABLE favorites_pokemons (
          id INTEGER PRIMARY KEY,
          userId INTEGER,
          pokemonId INTEGER,
          name TEXT,
          image TEXT,
          weight INTEGER,
          height INTEGER,
          types TEXT
        )
      ''');
      });
    } else {
      _database = await openDatabase(path);
    }
  }

  static Future<int> create(String tableName, Map<String, Object?> data) async {
    final db = await database;
    return await db!.insert(tableName, data);
  }

  static Future<List<Map<String, dynamic>>> all(String tableName) async {
    final db = await database;
    return await db!.query(tableName);
  }

  static Future<int> update(
      String tableName, int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db!.update(
      tableName,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, Object?>>> where(
      String tableName, String where, List<Object> args) async {
    final db = await database;
    final List<Map<String, Object?>> result = await db!.query(
      tableName,
      where: where,
      whereArgs: args,
    );
    return result;
  }

  static Future<int> delete(String tableName, int id) async {
    final db = await database;
    return await db!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
