import 'package:mathkraft/model/user_model.dart';

class UserComum extends User{
  UserComum({super.id, required super.nome, required super.senha, required super.telefone, super.pontuacao, super.ofensitvaCount});

  factory UserComum.fromUser(User user) {
    return UserComum(
      id: user.id,
      nome: user.nome,
      senha: user.senha,
      telefone: user.telefone,
      pontuacao: user.pontuacao,
      ofensitvaCount: user.ofensitvaCount
    );
  }
}