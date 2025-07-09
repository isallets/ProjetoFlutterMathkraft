import 'package:mathkraft/backend/model/user_model.dart';
import 'package:mathkraft/backend/service.dart/user_service.dart';

class UserController {
  static final UserController _instancia = UserController._();

  UserController._();
  

  static UserController get instance{
    return _instancia;
  }

  void criarUser(String nome, String senha, String telefone){
    UserService.instancia.criarUser(nome, senha, telefone);
  }

  
  dynamic logar (String nome, String senha){
    if(nome.isEmpty || senha.isEmpty){
      return "Usuário e/ou Senha inválidos!!!";
    }
    else{
      User? user = UserService.instancia.validaLogin(nome, senha);

      if(user == null){
        return "Usuário e/ou senha incorretos!!!";
      }
      else{
        return user;
      }
    }
    
  }
}