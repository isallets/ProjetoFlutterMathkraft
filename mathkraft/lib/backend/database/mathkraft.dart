import 'dart:io';
import 'package:flutter/services.dart' show rootBundle, ByteData;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initDatabaseWithPreloadedData() async {
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'mathkraft.db');
  bool exists = await databaseExists(path);

  if (!exists) {
    try {
      await Directory(dirname(path)).create(recursive: true);
      ByteData data = await rootBundle.load(join('assets', 'mathkraft.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } catch (e) {
      print("Erro ao copiar o banco de dados: $e");
    }
  }
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        isCompleted INTEGER NOT NULL
      )
    ''');
  }
  return await openDatabase(path);
  
}