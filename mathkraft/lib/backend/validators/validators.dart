import 'package:mathkraft/backend/classes/user_admin.dart';
import 'package:mathkraft/backend/classes/user_model.dart';
import 'package:mathkraft/backend/repository/user_repository.dart';

class Validators {

  User? validaLogin(String nome, String senha){
    for(int i=0; i<UserRepository.instance.listaUsuario.length; i++){
      if(
        UserRepository.instance.listaUsuario[i].nome == nome &&
        UserRepository.instance.listaUsuario[i].senha == senha
        ){
        return UserRepository.instance.listaUsuario[i];
      }
    }
    return null;
  }

  String verificaTipo(User u){
    if(u is UserAdmin){
      return 'adm';
    }
    else {
      return 'comum';
    }
  }
}