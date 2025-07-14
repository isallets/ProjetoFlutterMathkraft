import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mathkraft/model/user_model.dart';
import 'package:mathkraft/screens/tela_perfil.dart';
import 'package:mathkraft/widgets/app_bar_voltar_button.dart';
import 'package:mathkraft/screens/tela_recuperar_senha.dart';
import 'package:mathkraft/controller/user_controller.dart';

class TelaEditarConta extends StatefulWidget {
  final User userParaEditar;
  const TelaEditarConta({
      super.key,
      required this.userParaEditar,
    });

  @override
  State<TelaEditarConta> createState() => _TelaEditarContaState();
}

class _TelaEditarContaState extends State<TelaEditarConta> {
  final _nomeUsuarioController = TextEditingController();
  final _telefoneController = TextEditingController();

  final Color _corBotao = const Color.fromRGBO(204, 238, 243, 1.0);
  final Color _corTextoBotao = Colors.black;
  final Color _cinza = const Color(0xFF424242);

  @override
  void initState() {
    super.initState();
    _nomeUsuarioController.text = widget.userParaEditar.nome;
    _telefoneController.text = widget.userParaEditar.telefone;
  }

  @override
  void dispose() {
    _nomeUsuarioController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TelaPerfil()));
        });

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: _buildSuccessView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppBarVoltarButton voltarButton = AppBarVoltarButton();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: voltarButton.criar(context, Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset('lib/assets/MathKraft.png', height: 100.0),
              const SizedBox(height: 30),

              // Título "Editar Conta"
              const Text(
                'Editar Conta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),

              // Campo Nome de Usuário
              _buildTextField(
                controller: _nomeUsuarioController,
                labelText: 'Nome de usuário',
                icon: Icons.person_outline,
                borderColor: _cinza,
              ),
              const SizedBox(height: 20),

              // Campo Telefone
              _buildTextField(
                controller: _telefoneController,
                labelText: 'Telefone',
                icon: Icons.phone_iphone_outlined,
                keyboardType: TextInputType.phone,
                borderColor: _cinza,
              ),
              const SizedBox(height: 40),

              // Botão "Alterar Senha"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NovaSenhaDialog(userId: widget.userParaEditar.id!)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _corBotao,
                    foregroundColor: _corTextoBotao,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                      side: const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'ALTERAR SENHA',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Botão "Salvar Alterações"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    final novoNome = _nomeUsuarioController.text;
                    final novoTelefone = _telefoneController.text;

                    if (novoNome.isEmpty || novoTelefone.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Os campos não podem ficar em branco.'),
                          backgroundColor: Color.fromARGB(255, 255, 51, 0),
                        ),
                      );
                      return; 
                    }

                    // Cria o objeto User atualizado
                    final usuarioAtualizado = User(
                      id: widget.userParaEditar.id,
                      nome: _nomeUsuarioController.text,
                      senha: widget.userParaEditar.senha, 
                      telefone: _telefoneController.text,
                      pontuacao: widget.userParaEditar.pontuacao,
                      ofensitvaCount: widget.userParaEditar.ofensitvaCount
                    );

                    UserController.instance.updateUser(usuarioAtualizado);

                    if (UserController.instance.currentUser?.id == usuarioAtualizado.id) {
                        UserController.instance.currentUser = usuarioAtualizado;
                    }

                    _showSuccessDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _corBotao,
                    foregroundColor: _corTextoBotao,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                      side: const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'SALVAR ALTERAÇÕES',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSuccessView() {
    return const Column(
      key: ValueKey('successView'),
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Text(
          'Conta alterada\ncom sucesso!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Icon(Icons.check, color: Colors.black, size: 80),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Color borderColor = Colors.black,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade800, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      ),
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
    );
  }
}