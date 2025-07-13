import 'package:mathkraft/model/user_model.dart';

class UserAdmin extends User{
  UserAdmin({super.id, required super.nome, required super.senha, required super.telefone, super.pontuacao, super.ofensitvaCount});

  factory UserAdmin.fromUser(User user) {
    return UserAdmin(
      id: user.id,
      nome: user.nome,
      senha: user.senha,
      telefone: user.telefone,
      pontuacao: user.pontuacao,
      ofensitvaCount: user.ofensitvaCount
    );
  }
}