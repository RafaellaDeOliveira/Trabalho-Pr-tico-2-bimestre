import 'package:prova2/provider/DatabaseProvider.dart';
import 'package:sqflite/sqflite.dart';

class ProdutosProvider extends DatabaseProvider {
  static final table = "PRODUTOS";
  static final columnId = "_id";
  static final columnNome = "nome";
  static final columnLocal = "local";
  static final columnComentarios = "comentarios";

  // String create =

  ProdutosProvider()
      : super(
            sql:
                "CREATE TABLE $table($columnId INTEGER PRIMARY KEY, $columnNome TEXT NOT NULL, $columnLocal TEXT, $columnComentarios TEXT)");

  //CRUD
  Future<int> insert(Map<String, dynamic> linha) async {
    Database? db = await super.database;
    return await db!.insert(table, linha);
  }

  Future<List<Map<String, dynamic>>> selectAll() async {
    Database? db = await super.database;
    return db!.query(table);
  }

  //UPDATE
  Future<int> update(Map<String, dynamic> linha) async {
    Database? db = await super.database;
    int id = linha[columnId];
    return await db!
        .update(table, linha, where: "$columnId = ?", whereArgs: [id]);
  }

  //DELETE
  Future<int> delete(int id) async {
    Database? db = await super.database;
    return await db!.delete(table, where: "$columnId = ?", whereArgs: [id]);
  }

  //executar comados personalizados no banco da dados
  //COUNT()
  Future<int?> selectCountAll() async {
    Database? db = await super.database;
    return Sqflite.firstIntValue(
      await db!.rawQuery("SELECT COUNT($columnId) FROM $table"),
    );
  }

  Future<int?> queryRowCount() async {
    Database? db = await super.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }
}
