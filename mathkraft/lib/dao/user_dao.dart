import 'package:mathkraft/database/mathkraft_db.dart';
import 'package:mathkraft/model/user_model.dart';

class UserDAO {
  static Future<int> inserir(User user) async {
    try {
      var db = await MathkraftDb.getInstance();
      return await db.insert('user', user.toMap());

    } catch (e) {
      print("ERRO AO INSERIR USUÁRIO: $e");
      return -1;
    }
  }

  static Future<void> atualizar(User user) async {
    var db = await MathkraftDb.getInstance();
    await db.update('user', user.toMap(), where: 'id = ?', whereArgs: [user.id]);  
  }

  static Future<void> deletar(int id) async {
    var db = await MathkraftDb.getInstance();
    await db.delete('user', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<User>> carregarUsers() async {
    var db = await MathkraftDb.getInstance();
    List<Map> result = await db.query('user');
    return result.map((e) => User.fromMap(e as Map<String, dynamic>)).toList();
  }

  static Future<User?> getByUser(String user) async {
    var db = await MathkraftDb.getInstance();
    List<Map> result = await db.query('user', where: 'nome = ?', whereArgs: [user],);

    if (result.isNotEmpty) {
      return User.fromMap(result.first as Map<String, dynamic>);
    }
    return null; 
  }

  static Future<User?> getById(int id) async {
    var db = await MathkraftDb.getInstance();
    List<Map> result = await db.query('user', where: 'id = ?', whereArgs: [id],);

    if (result.isNotEmpty) {
      return User.fromMap(result.first as Map<String, dynamic>);
    }
    return null; 
  }

  static Future<bool> ehAdmin(int userId) async {
    var db = await MathkraftDb.getInstance();
    final result = await db.query('id_admin', where: 'id = ?', whereArgs: [userId]);
    return result.isNotEmpty;
  }

  static Future<void> tornaAdmin(int userId) async {
    var db = await MathkraftDb.getInstance();
    await db.insert('id_admin', {'id': userId});
  }
}
