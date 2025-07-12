import 'dart:developer';

import 'package:mathkraft/database/mathkraft_db.dart';
import 'package:mathkraft/repository/user_repository.dart';

class UserController {
  static final UserController _instancia = UserController._();
  late int idLogado;
  late String nome;
  late String senha;
  late String telefone;
  late int pontuacao;

  UserController._();

  static UserController get instance{
    return _instancia;
  }

  Future<List<Map>> criarUser(String nome, String senha1, String telefone) async {
    var db = await MathkraftDb.getInstance();
    List<Map> user = await db.rawQuery('SELECT * FROM user WHERE nome="$nome"');
    if(user.isEmpty){
      UserRepository.instance.addUser(nome, senha1, telefone);
    }
    return user;
  }

  Future<dynamic> logar (String nome, String senha) async{
    
    var db = await MathkraftDb.getInstance();
    List<Map> userLogin = await UserRepository.instance.buscarNome(nome);

    if(nome.isEmpty || senha.isEmpty){
      return "Usuário e/ou Senha inválidos!!!";
    }
    else{
      if(userLogin.isEmpty){
        return "Usuário e/ou senha incorretos!!!";
      }
      else{
        for(var user in userLogin){
          if(user['senha'] == senha){
            idLogado = user['id'];
            this.nome = user['nome'];
            this.senha = user['senha'];
            telefone = user['telefone'];
            pontuacao = user['pontuacao'];
          }
        }
        log(idLogado.toString());
        List<Map> admin = await db.rawQuery('SELECT * FROM user INNER JOIN id_admin ON id_admin.id = user.id WHERE user.id = $idLogado');
        
        if(admin.isNotEmpty){
          return 0;
        }
        else{
          return 1;
        }
      }
    }
  }
}