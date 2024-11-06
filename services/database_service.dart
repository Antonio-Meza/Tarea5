import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/pc_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initializeDB();
    return _db!;
  }

  Future<Database> _initializeDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'pc_inventory_v2.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE pcs(id INTEGER PRIMARY KEY, cpuType TEXT, ramSize TEXT, storageType TEXT)',
    );
  }

  Future<void> addPC(PCInventory pc) async {
    final db = await _instance.database;
    await db.insert('pcs', pc.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<PCInventory>> getComputers() async {
    final db = await _instance.database;
    final List<Map<String, dynamic>> maps = await db.query('pcs');
    return List.generate(maps.length, (index) => PCInventory.fromMap(maps[index]));
  }

  Future<void> updatePC(PCInventory pc) async {
    final db = await _instance.database;
    await db.update('pcs', pc.toMap(), where: 'id = ?', whereArgs: [pc.id]);
  }

  Future<void> deleteComputer(int id) async {
    final db = await _instance.database;
    await db.delete('pcs', where: 'id = ?', whereArgs: [id]);
  }
}
