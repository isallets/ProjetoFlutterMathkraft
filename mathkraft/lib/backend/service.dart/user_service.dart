import 'package:mathkraft/backend/classes/user_model.dart';
import 'package:mathkraft/backend/repository/user_repository.dart';
import 'package:mathkraft/backend/validators/validators.dart';

class UserService {
  late UserRepository userRepository;
  static final UserService _instancia = UserService._();
  Validators v = Validators();

//construtor anonimo para impedir instâncias em outras classes
  UserService._(){
    userRepository = UserRepository.instance;
  }

//função para permitir acesso à instância
  static UserService get instancia {
    return _instancia;
  }

//função para criar usuário
  void addUser (String nome, String senha, String telefone){
    userRepository.addUser(nome, senha, telefone);
  }

//função validar login
  User? validaLogin(String nome, String senha){
    return v.validaLogin(nome, senha);
  }

//função para verificar tipo de usuario
  String verificaTipo (User u){
    return v.verificaTipo(u);
  }
}
