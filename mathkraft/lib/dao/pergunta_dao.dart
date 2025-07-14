import 'package:mathkraft/database/mathkraft_db.dart';
import 'package:mathkraft/model/pergunta_model.dart';

class PerguntaDAO {
  static Future<int> inserir(Pergunta pergunta) async {
    try {
      var db = await MathkraftDb.getInstance();
      return await db.insert('pergunta', pergunta.toMap());
    } catch (e) {
      print("ERRO AO INSERIR PERGUNTA: $e");
      return -1;
    }
  }

  static Future<void> atualizar(Pergunta pergunta) async {
    var db = await MathkraftDb.getInstance();
    await db.update(
      'pergunta',
      pergunta.toMap(),
      where: 'id = ?',
      whereArgs: [pergunta.id]
    );
  }

  static Future<void> deletar(int id) async {
    var db = await MathkraftDb.getInstance();
    await db.delete('pergunta', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Pergunta>> carregarPergunta() async {
    var db = await MathkraftDb.getInstance();
    List<Map> result = await db.query('pergunta');
    return result
        .map((e) => Pergunta.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  static Future<Pergunta?> getByPergunta(String conta) async {
    var db = await MathkraftDb.getInstance();
    List<Map> result = await db.query(
      'pergunta',
      where: 'conta = ?',
      whereArgs: [conta],
    );

    if (result.isNotEmpty) {
      return Pergunta.fromMap(result.first as Map<String, dynamic>);
    }
    return null;
  }

  static Future<Pergunta?> getById(int id) async {
    var db = await MathkraftDb.getInstance();
    List<Map> result = await db.query(
      'pergunta',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Pergunta.fromMap(result.first as Map<String, dynamic>);
    }
    return null;
  }
}
