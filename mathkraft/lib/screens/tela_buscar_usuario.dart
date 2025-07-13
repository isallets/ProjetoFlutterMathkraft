import 'package:flutter/material.dart';
import 'package:mathkraft/screens/tela_buscar_todos_usuarios.dart';
import 'package:mathkraft/widgets/header_mathkraft.dart';
import 'package:mathkraft/widgets/admin_menu_navigation_bar_widget.dart';
import 'package:mathkraft/controller/user_controller.dart';
import 'package:mathkraft/model/user_model.dart';

class TelaBuscarUsuario extends StatefulWidget {
  const TelaBuscarUsuario({super.key});

  @override
  State<TelaBuscarUsuario> createState() => _TelaBuscarUsuarioState();
}

class _TelaBuscarUsuarioState extends State<TelaBuscarUsuario> {
  late TextEditingController _nomeController;
  late TextEditingController _idController;

  final Color _laranjaClaro = Colors.yellow[100]!;

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores
    _nomeController = TextEditingController();
    _idController = TextEditingController();
  }

  @override
  void dispose() {
    // Descarte os controladores para liberar recursos
    _nomeController.dispose();
    _idController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Color borderColor = Colors.black,
    double borderWidth = 2.0,
    double borderRadius = 16.0,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration:
      InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(color: Colors.orange, width: borderWidth),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      ),
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
    );
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
            const Text(
              'Buscar usuário:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 100),

            // Campo Nome:
            const Text(
              'Nome:',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _nomeController,
              labelText: 'Nome de usuário',
              borderColor: Colors.black,
              borderRadius: 16.0,
              borderWidth: 2.0,
            ),

            const SizedBox(height: 20),

            // Campo ID:
            const Text(
              'ID:',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            _buildTextField(
              controller: _idController,
              labelText: 'ID',
              keyboardType: TextInputType.number,
              borderColor: Colors.black,
              borderRadius: 16.0,
              borderWidth: 2.0,
            ),

            const SizedBox(height: 70),

            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaBuscarTodosUsuarios()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _laranjaClaro,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    elevation: 0,
                  ),
                  child: const Text(
                    'BUSCAR TODOS',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Botão BUSCAR
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () async {
                    final String nomeDigitado = _nomeController.text;
                    final String idDigitado = _idController.text;
                    final controller = UserController.instance;
                    User? usuarioEncontrado;

               if (idDigitado.isNotEmpty) {
                      final int? id = int.tryParse(idDigitado);
                      if (id != null) {
                        usuarioEncontrado = await controller.getUserById(id);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ID inválido. Use apenas números.')));
                        return;
                      }
                    } 
                    else if (nomeDigitado.isNotEmpty) {
                      usuarioEncontrado = await controller.getUserByUsername(nomeDigitado);
                    } 
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, preencha um dos campos.')));
                      return;
                    }
                    if (usuarioEncontrado != null) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Usuário Encontrado!'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ID: ${usuarioEncontrado!.id}'),
                              Text('Nome: ${usuarioEncontrado.nome}'),
                              Text('Telefone: ${usuarioEncontrado.telefone}'),
                              Text('Pontuação: ${usuarioEncontrado.pontuacao ?? 0}'),
                            ],
                          ),
                          actions: [
                            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK')),
                          ],
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Usuário não encontrado.'), backgroundColor: Colors.red));
                    }
                  },
                  child: const Text(
                    'BUSCAR',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: adminMenuBottomNavigationBar(context, 1),
    );
  }
}