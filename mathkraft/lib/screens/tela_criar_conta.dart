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

//construtor anonimo para impedir instâncias em outras classes
  UserCriarService._(){
    userRepository = UserRepository.instance;
  }

//função para permitir acesso à instância
  static UserCriarService get instancia {
    return _instancia;
  }

  void criarUser (String nome, String senha, String telefone){
    userRepository.addUser(nome, senha, telefone);
  }
}

class TelaCriarConta extends StatelessWidget {
  const TelaCriarConta({super.key});

  @override
  Widget build(BuildContext context) {
    const Color laranja = Color.fromRGBO(249, 206, 79, 1);
    const Color cinza = Color(0xFF424242);
    final AppBarVoltarButton voltarButton = AppBarVoltarButton();
    late TextEditingController _nome = TextEditingController();
    late TextEditingController _senha1 = TextEditingController();
    late TextEditingController _senha2 = TextEditingController();
    late TextEditingController _telefone = TextEditingController();


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

    return Scaffold(
      backgroundColor: Colors.white,
      // Barra superior com botão de voltar
      appBar: voltarButton.criar(context, Colors.white),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              Image.asset('lib/assets/MathKraft.png',
                height: 120,
              ),
              const SizedBox(height: 30),

              // "Crie uma conta!"
              const Text(
                'Crie uma conta!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: cinza,
                ),
              ),
              const SizedBox(height: 40),

              // Campos de Texto
              _buildTextField(
                controller: _nome,
                labelText: 'Nome de usuário',
                icon: Icons.person_outline,
                borderColor: cinza,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _senha1,
                labelText: 'Senha',
                icon: Icons.lock_outline,
                obscureText: true,
                borderColor: cinza,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _senha2,
                labelText: 'Repita a senha',
                icon: Icons.lock_outline,
                obscureText: true,
                borderColor: cinza,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _telefone,
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
                  UserController.instance.criarUser(_nome.text, _senha1.text, _telefone.text);
                  _showSuccessDialog;
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

  // View de Sucesso
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

  // Widget auxiliar para criar os campos de texto padronizados
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
      ),
    );
  }
}
