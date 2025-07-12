import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class MathkraftDb {
  static late Database _instance;
  static const String dbName = 'mathkraft8.db';

  static Future<Database> getInstance() async {
    String databasesPath = await getDatabasesPath();
    var path = databasesPath + dbName;
    debugPrint(path);
    debugPrint(path);
    _instance = await openDatabase(path, onCreate: _onCreate, version: 1, onOpen: _onOpen,
      onUpgrade: _onUpgrade, onDowngrade: _onDowngrade);

    return _instance;
  }

  static void _onCreate(Database db, int ver) async {
    debugPrint('Criando a tabela user');
    await db.execute('CREATE TABLE user(id INTEGER PRIMARY KEY, nome TEXT, senha TEXT, telefone TEXT, pontuacao INTEGER)');
    await db.execute('CREATE TABLE id_admin(id INTEGER PRIMARY KEY)');
  }

  static void _onOpen(Database db) async {
    debugPrint('Versao do banco: ${await db.getVersion()}');
  }

  static void _onUpgrade(Database db, int oldV, int newV) async {
    debugPrint('Fazendo upgrade da versão $oldV para $newV');
    // rotinas de atualização, criação de tabelas, etc.
  }

  static void _onDowngrade(Database db, int oldV, int newV) async {
    debugPrint('Fazendo downgrade da versão $oldV para $newV');
    // rotinas de atualização, criação de tabelas, etc.
  }
}
