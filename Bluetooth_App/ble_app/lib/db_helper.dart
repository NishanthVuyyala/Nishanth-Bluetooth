import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'ble_connections.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE connections (
        id INTEGER PRIMARY KEY,
        deviceId TEXT NOT NULL,
        deviceName TEXT,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertConnection(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('connections', row);
  }

  Future<List<Map<String, dynamic>>> queryAllConnections() async {
    Database db = await database;
    return await db.query('connections');
  }
}