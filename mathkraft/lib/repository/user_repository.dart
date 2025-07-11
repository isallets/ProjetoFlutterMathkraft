import 'dart:developer';

import 'package:mathkraft/model/user_admin.dart';
import 'package:mathkraft/model/user_comum.dart';
import 'package:mathkraft/model/user_model.dart';

class UserRepository {
  static final UserRepository _instancia = UserRepository._();
  late final List<User> listaUsuario;
  late int contId;

  UserRepository._(){
    listaUsuario = [];
    contId = 0;
    listaUsuario.add(UserAdmin(contId, 'admin', 'admin', '(99) 99999-9999'));
  }

  static UserRepository get instance{
    return _instancia;
  }

  void addUser(String nome, String senha, String telefone){
    User user = UserComum(++contId, nome, senha, telefone);
    listaUsuario.add(user);
    log(listaUsuario[listaUsuario.length-1].nome);
  }
  
}