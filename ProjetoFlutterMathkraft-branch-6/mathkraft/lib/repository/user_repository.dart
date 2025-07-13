import 'dart:developer';

import 'package:mathkraft/dao/user_dao.dart';
import 'package:mathkraft/model/user_admin.dart';
import 'package:mathkraft/model/user_comum.dart';
import 'package:mathkraft/model/user_model.dart';

class UserRepository {
  static final UserRepository instance = UserRepository._();
  
  UserRepository._(){
    _criaAdmin();
  }

  void _criaAdmin() async {
    final existeAdmin = await UserDAO.getByUser('admin');

    if(existeAdmin == null){
      var admin = UserAdmin(nome: 'admin', senha: 'admin', telefone: '(99) 99999-9999');
      log('Criando Admin');
      int id = await UserDAO.inserir(admin);

      if (id != -1) {
        await UserDAO.tornaAdmin(id);
      }
    }
  }

  Future<User?> login(String username, String senha) async {
    final user = await UserDAO.getByUser(username);

    if (user == null || user.senha != senha){
      return null;
    } 

    final ehAdmin = await UserDAO.ehAdmin(user.id!);
    
    if (ehAdmin) {
      return UserAdmin.fromUser(user);
    } else {
      return UserComum.fromUser(user);
    }
  }

  Future<User?> addUser(String nome, String senha, String telefone) async {
    final existeUser = await UserDAO.getByUser(nome);

    if (existeUser != null) {
      log('Usuário já existe!');
      return null; 
    }
    final novoUser = UserComum(nome: nome, senha: senha, telefone: telefone);
    await UserDAO.inserir(novoUser);
    return novoUser;
  }

  Future<List<User>> getAllUsers() async {
    return await UserDAO.carregarUsers();
  }
  
  Future<void> deleteUser(int id) async {
    await UserDAO.deletar(id);
  }

  Future<void> updateUser(User user) async {
    await UserDAO.atualizar(user);
  }

  Future<User?> getUserById(int id) async {
    return await UserDAO.getById(id);
  }

  Future<User?> getUserByUsername(String nome) async {
    return await UserDAO.getByUser(nome);
  }
}