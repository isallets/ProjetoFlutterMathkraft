import 'package:mathkraft/database/mathkraft_db.dart';
import 'package:mathkraft/model/user_model.dart';

class UserDAO {
  static Future<int> inserir(User user) async {
    var db = await MathkraftDb.getInstance();
    return await db.insert('user', user.toMap());
  }

  static Future<void> atualizar(User user) async {
    var db = await MathkraftDb.getInstance();
    await db.update('user', user.toMap());
  }

  static Future<void> deletar(User user) async {
    var db = await MathkraftDb.getInstance();
    await db.delete('user', where: 'id = ?', whereArgs: [user.id]);
  }

  static Future<List<User>> carregarUsers() async {
    var db = await MathkraftDb.getInstance();
    List<Map> result = await db.query('user');
    return result.map((e) => User.fromMap(e as Map<String, dynamic>)).toList();
  }
}
