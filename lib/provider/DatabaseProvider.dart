import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final _databaseName = "ListaCompras.db";
  static final _databaseVersion = 1;
  final sql;

  DatabaseProvider({required this.sql});

  //construcao SINGLETON
  // DatabaseProvider._privateConstructor();
  // static final DatabaseProvider instancia =
  //     DatabaseProvider._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  //inicializa o BD
  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  //cria as tabelas
  Future _onCreate(Database db, int version) async {
    await db.execute(sql);
  }
}
