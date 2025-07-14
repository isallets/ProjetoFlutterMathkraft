import 'package:flutter/material.dart';
import 'package:mathkraft/controller/user_controller.dart';
import 'package:mathkraft/model/user_model.dart';
import 'package:mathkraft/widgets/header_mathkraft.dart';
import 'package:mathkraft/widgets/admin_menu_navigation_bar_widget.dart';
import 'package:mathkraft/screens/tela_editar_conta.dart';

class TelaBuscarTodosUsuarios extends StatefulWidget {
  const TelaBuscarTodosUsuarios({super.key});

  @override
  State<TelaBuscarTodosUsuarios> createState() => _TelaBuscarTodosUsuariosState();
}

class _TelaBuscarTodosUsuariosState extends State<TelaBuscarTodosUsuarios> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _buscarUsuarios();
  }

  Future<void> _buscarUsuarios() async {
    final listaDeUsuarios = await UserController.instance.getAllUsers();
        setState(() {
        _users = listaDeUsuarios;
      });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MathKraftHeader(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Usuários:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: _users.isEmpty
                    ? const Center(child: Text('Nenhum usuário encontrado.'))
                    : ListView.builder(
                        itemCount: _users.length,
                        itemBuilder: (context, index) {
                          final user = _users[index];
                          return UserListItem(
                            user: user,
                            onActionCompleted: _buscarUsuarios,
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    elevation: 0,
                  ),
                  child: const Text(
                    'VOLTAR',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: adminMenuBottomNavigationBar(context, 1),
    );
  }
}

class UserListItem extends StatelessWidget {
  final User user;
  final VoidCallback onActionCompleted;

  const UserListItem({
    super.key,
    required this.user,
    required this.onActionCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(user.nome, style: const TextStyle(fontSize: 20)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.black),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaEditarConta(userParaEditar: user)),
                  );
                  onActionCompleted();
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _showDeleteDialog(context, user, onActionCompleted),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  void _showDeleteDialog(BuildContext context, User user, VoidCallback onActionCompleted) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Tem certeza que deseja excluir o usuário ${user.nome}?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              await UserController.instance.deleteUser(user.id!);
              Navigator.of(context).pop();
              onActionCompleted();
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}