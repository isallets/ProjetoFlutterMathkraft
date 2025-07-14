import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mathkraft/model/user_admin.dart';
import 'package:mathkraft/model/user_model.dart';
import 'package:mathkraft/repository/user_repository.dart';
import 'package:mathkraft/screens/tela_admin.dart';
import 'package:mathkraft/screens/tela_boas_vindas.dart';
import 'package:mathkraft/screens/tela_inicial_jogos.dart';

class UserController {
  static final UserController instance = UserController._();
  final UserRepository _repository = UserRepository.instance;

  User? currentUser;

  UserController._();

  Future<void> login(BuildContext context, String username, String senha) async {
    if (username.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.'), backgroundColor: Colors.orange),
      );
      return;
    }
    
    final user = await _repository.login(username, senha);

    if (user != null) {
      currentUser = user;
      
      if (user is UserAdmin) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TelaAdmin()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaInicialJogos()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nome de usuário ou senha inválidos.'), backgroundColor: Colors.red),
      );
    }
  }

  Future<bool> ehAdmin() async{
    return _repository.ehAdmin(currentUser!.id!);
  }

  Future<bool> createUser(String nome, String senha, String telefone) async {
    final novoUser = await _repository.addUser(nome, senha, telefone);
    return novoUser != null; 
  }

  void logout(BuildContext context) {
    currentUser = null;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const TelaBoasVindas()),
      (Route<dynamic> route) => false, 
    );
  }

  Future<void> deletarConta(BuildContext context) async {
    if (currentUser != null) {
      await _repository.deleteUser(currentUser!.id!);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conta excluída com sucesso.'), backgroundColor: Colors.green),
      );
      logout(context); 
    }
  } 
  Future<List<User>> getAllUsers() {
    return _repository.getAllUsers();
  }

  Future<void> deleteUser(int id) {
    return _repository.deleteUser(id);
  }

  Future<void> updateUser(User user) {
    if(currentUser!.id == user.id){
      currentUser = user;
    }
    log('${user.ofensitvaCount} + ${user.pontuacao}');
    return _repository.updateUser(user);
  }

  Future<User?> getUserById(int id) {
    return _repository.getUserById(id);
  }

  Future<User?> getUserByUsername(String nome) {
    return _repository.getUserByUsername(nome);
  }

  Future<User?> verificarUsuario(String nome, String telefone) async {
    final user = await _repository.getUserByUsername(nome);

    if (user != null && user.telefone == telefone) {
      return user;
    }
    return null; 
  }

  Future<String?> redefinirSenha({
    required int userId,
    required String? novaSenha,
    required String confirmarSenha,
  }) async {
    if (novaSenha != confirmarSenha) {
      return 'As senhas não coincidem';
    }
    if (novaSenha == null) {
      return 'Digite a nova senha';
    }

    final user = await _repository.getUserById(userId);
    if (user == null) {
      return 'Erro: Usuário não encontrado.';
    }

    final usuarioComNovaSenha = User(
      id: user.id,
      nome: user.nome,
      telefone: user.telefone,
      pontuacao: user.pontuacao,
      ofensitvaCount: user.ofensitvaCount,
      senha: novaSenha, 
    );

    await _repository.updateUser(usuarioComNovaSenha);
    
    if (currentUser?.id == userId) {
      currentUser = usuarioComNovaSenha;
    }

    return null; 
  }

}