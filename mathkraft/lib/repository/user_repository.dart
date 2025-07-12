import 'dart:developer';

import 'package:mathkraft/dao/user_dao.dart';
import 'package:mathkraft/database/mathkraft_db.dart';
import 'package:mathkraft/model/user_admin.dart';
import 'package:mathkraft/model/user_comum.dart';
import 'package:mathkraft/model/user_model.dart';

class UserRepository {
  static final UserRepository _instancia = UserRepository._();
  
  UserRepository._(){
    _criaAdmin();
  }

  static UserRepository get instance{
    return _instancia;
  }

  void _criaAdmin() async {
    var db = await MathkraftDb.getInstance();
    List<Map> admins = await db.rawQuery('SELECT * FROM id_admin');

    if(admins.isEmpty){
      var admin = UserAdmin(nome: 'admin', senha: 'admin', telefone: '(99) 99999-9999');
      log('Criando Admin');
      int i = await UserDAO.inserir(admin);
      await db.insert('id_admin', <String, dynamic>{'id': i});
    }
  }

  Future<List<Map>> buscarNome (String nome) async{
    var db = await MathkraftDb.getInstance();
    return db.rawQuery('SELECT * FROM user WHERE nome = "$nome"');
  }

  Future<int> addUser(String nome, String senha, String telefone) async {
    var user = UserComum(nome: nome, senha: senha, telefone: telefone);
    int i = await UserDAO.inserir(user);

    log(i.toString());
    return i;
  }
  
}