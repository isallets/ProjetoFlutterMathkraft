import 'package:flutter/material.dart';
import 'package:mathkraft/controller/user_controller.dart';
import 'dart:async';
import 'package:mathkraft/widgets/app_bar_voltar_button.dart';

class TelaCriarConta extends StatefulWidget {
  const TelaCriarConta({super.key});

  @override
  State<TelaCriarConta> createState() => _TelaCriarContaState();
}

class _TelaCriarContaState extends State<TelaCriarConta> {
  late TextEditingController _nomeController;
  late TextEditingController _senha1Controller;
  late TextEditingController _senha2Controller;
  late TextEditingController _telefoneController;

  final Color laranja = const Color.fromRGBO(249, 206, 79, 1);
  final Color cinza = const Color(0xFF424242);

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _senha1Controller = TextEditingController();
    _senha2Controller = TextEditingController();
    _telefoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _senha1Controller.dispose();
    _senha2Controller.dispose();
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
        });

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: _buildSuccessView(),
        );
      },
    );
  }

  void _criarUser() async {
    final bool _criada = await UserController.instance.createUser(
      _nomeController.text,
      _senha1Controller.text,
      _telefoneController.text,
    );

    if (mounted) {
      if (_criada) {
        _showSuccessDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Já existe um usuário com este nome.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildSuccessView() {
    return const Column(
      key: ValueKey('successView'),
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Text(
          'Conta criada\ncom sucesso!',
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
    required Color borderColor,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.grey),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Image.asset('lib/assets/MathKraft.png', height: 120),
              const SizedBox(height: 30),

              const Text(
                'Crie uma conta!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 40),

              // Campos de Texto
              _buildTextField(
                controller: _nomeController,
                labelText: 'Nome de usuário',
                icon: Icons.person_outline,
                borderColor: cinza,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _senha1Controller,
                labelText: 'Senha',
                icon: Icons.lock_outline,
                obscureText: true,
                borderColor: cinza,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _senha2Controller,
                labelText: 'Repita a senha',
                icon: Icons.lock_outline,
                obscureText: true,
                borderColor: cinza,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _telefoneController,
                labelText: 'Telefone',
                icon: Icons.phone_iphone_outlined,
                keyboardType: TextInputType.phone,
                borderColor: cinza,
              ),
              const SizedBox(height: 40),

              //Botão de Cadastro
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: laranja,
                  foregroundColor: cinza,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  if (_senha1Controller.text != _senha2Controller.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('As senhas não coincidem!')),
                    );
                    return;
                  }
                  if (_nomeController.text.isEmpty ||
                      _senha1Controller.text.isEmpty ||
                      _telefoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Por favor, preencha todos os campos.')),
                    );
                    return;
                  }
                  if(_telefoneController.text.length != 11){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Telefone Inválido')),
                    );
                    return;
                  }
                  _criarUser();
               
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Criar conta',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}