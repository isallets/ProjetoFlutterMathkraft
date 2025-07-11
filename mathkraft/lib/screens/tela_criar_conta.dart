import 'package:flutter/material.dart';
import 'package:mathkraft/controller/user_controller.dart';
import 'dart:async';
import 'package:mathkraft/widgets/app_bar_voltar_button.dart';
import 'package:mathkraft/repository/user_repository.dart';
import 'package:mathkraft/validators/validators.dart';

class UserCriarService {
  late UserRepository userRepository;
  static final UserCriarService _instancia = UserCriarService._();
  Validators v = Validators();

  // Construtor anônimo para impedir instâncias em outras classes
  UserCriarService._(){
    userRepository = UserRepository.instance;
  }

  // Função para permitir acesso à instância
  static UserCriarService get instancia {
    return _instancia;
  }

  void criarUser (String nome, String senha, String telefone){
    userRepository.addUser(nome, senha, telefone);
  }
}

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
    // Descarte os controladores para liberar recursos
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
        // Após 2 segundos, o dialog e a tela de cadastro são fechados
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
    // Instancie a classe AppBarVoltarButton aqui dentro do build
    final AppBarVoltarButton voltarButton = AppBarVoltarButton();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: voltarButton.criar(context, Colors.white), // Usa seu AppBarVoltarButton
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
              _buildTextField( // Usando o método auxiliar
                controller: _nomeController,
                labelText: 'Nome de usuário',
                icon: Icons.person_outline,
                borderColor: cinza,
              ),
              const SizedBox(height: 20),
              _buildTextField( // Usando o método auxiliar
                controller: _senha1Controller,
                labelText: 'Senha',
                icon: Icons.lock_outline,
                obscureText: true,
                borderColor: cinza,
              ),
              const SizedBox(height: 20),
              _buildTextField( // Usando o método auxiliar
                controller: _senha2Controller, // Associado ao controlador
                labelText: 'Repita a senha',
                icon: Icons.lock_outline,
                obscureText: true,
                borderColor: cinza,
              ),
              const SizedBox(height: 20),
              _buildTextField( // Usando o método auxiliar
                controller: _telefoneController, // Associado ao controlador
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
                  // --- Lógica de Validação e Criação de Usuário ---
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

                  // Chamada correta ao UserController para criar o usuário
                  UserController.instance.criarUser(
                    _nomeController.text,
                    _senha1Controller.text,
                    _telefoneController.text,
                  );
                  _showSuccessDialog(); // Chamada CORRETA da função
                  // --- Fim da Lógica ---
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