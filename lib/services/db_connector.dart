import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseConnector {
  static final DataBaseConnector instance = DataBaseConnector._init();

  static Database? _database;

  DataBaseConnector._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('app_database.db');
    return _database!;
  }

   Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1);
  }

  
}