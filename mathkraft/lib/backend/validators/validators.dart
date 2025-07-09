import 'package:mathkraft/backend/model/user_admin.dart';
import 'package:mathkraft/backend/model/user_model.dart';
import 'package:mathkraft/backend/repository/user_repository.dart';

class Validators {
  final List<String> dddsInvalidos = [
    '01', '02', '03', '04', '05', '06', '07', '08', '09', '10',
    '20', '23', '25', '26', '29', '30', '36', '39', '40', '50',
    '52', '56', '57', '58', '59', '60', '70', '72', '76', '78', 
    '80', '90'
  ];

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