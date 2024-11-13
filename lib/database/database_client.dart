import 'package:goose/models/database/grocery_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {
  static Database? _database;

  static const _databaseName = "groceries.db";
  static const _tableName = "groceries";

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute("""
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        category TEXT NOT NULL
      )
    """);
  }

  Future<List<GroceryEntity>> getGroceries() async {
    final db = await database;
    final entities = await db.query(_tableName);
    return entities.map((e) => GroceryEntity.fromJson(e)).toList();
  }

  Future<GroceryEntity> addGrocery(GroceryEntity entity) async {
    final db = await database;
    final id = await db.insert(
      _tableName,
      entity.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return entity.copyWith(id: id);
  }

  Future<GroceryEntity> updateGrocery(GroceryEntity entity) async {
    final db = await database;
    await db.update(
      _tableName,
      entity.toJson(),
      where: "id = ?",
      whereArgs: [entity.id],
    );
    return entity;
  }

  Future<GroceryEntity> deleteGrocery(GroceryEntity entity) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [entity.id],
    );
    return entity;
  }
}
