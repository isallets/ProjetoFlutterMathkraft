import 'package:flutter/material.dart';
import 'package:mathkraft/model/user_admin.dart';
import 'package:mathkraft/controller/user_controller.dart';
import 'package:mathkraft/screens/tela_criar_conta.dart';
import 'package:mathkraft/screens/tela_recuperar_senha.dart';
import 'package:mathkraft/screens/tela_admin.dart';
import 'package:mathkraft/screens/tela_inicial_jogos.dart';
import 'package:mathkraft/repository/user_repository.dart';
import 'package:mathkraft/validators/validators.dart';
import 'package:mathkraft/model/user_model.dart';
import 'dart:async';

class UserLoginService {
  late UserRepository userRepository;
  static final UserLoginService _instancia = UserLoginService._();
  Validators v = Validators();

  // Construtor anônimo para impedir instâncias em outras classes
  UserLoginService._(){
    userRepository = UserRepository.instance;
  }

  // Função para permitir acesso à instância
  static UserLoginService get instancia {
    return _instancia;
  }

  User? validaLogin(String nome, String senha){
    return v.validaLogin(nome, senha);
  }

  String verificaTipo (User u){
    return v.verificaTipo(u);
  }
}

class TelaBoasVindas extends StatefulWidget {
  const TelaBoasVindas({super.key});

  @override
  State<TelaBoasVindas> createState() => _TelaBoasVindasState();
}

class _TelaBoasVindasState extends State<TelaBoasVindas> {
  late TextEditingController _nomeController;
  late TextEditingController _senhaController;
  var _loginResult; // Variável para armazenar o resultado do login

  final Color laranja = Colors.orange;
  final Color preto = Colors.black;
  final Color cinza = const Color(0xFF424242);

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _senhaController = TextEditingController();
  }

  @override
  void dispose() {
    // Descarte os controladores para liberar recursos
    _nomeController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Widget _buildRichTextLink(String text, String linkText, VoidCallback onTap, Color linkColor, Color textColor) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Text.rich(
          TextSpan(
            text: text,
            style: TextStyle(color: textColor, fontSize: 16),
            children: [
              TextSpan(
                text: linkText,
                style: TextStyle(
                  color: linkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'MathKraft',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Image.asset('lib/assets/MathKraft.png', height: 150),
                const SizedBox(height: 48),

                //Campo "Nome de usuário"
                TextField(
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                  decoration:
                  InputDecoration(
                    labelText: 'Nome de usuário',
                    prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: laranja, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //Campo "Senha"
                TextField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration:
                  InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: laranja, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                //Botão "Entrar"
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: preto,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    setState(() {
                      _loginResult = UserController.instance.logar(
                        _nomeController.text,
                        _senhaController.text,
                      );
                    });

                    if (_loginResult.runtimeType == String) {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          Timer(const Duration(seconds: 2), () {
                            Navigator.of(dialogContext).pop();
                          });
                          return AlertDialog(
                            backgroundColor: const Color.fromARGB(255, 255, 179, 149),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _loginResult,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (_loginResult.runtimeType == UserAdmin) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const TelaAdmin()),
                      );
                    } else if (_loginResult is User) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => TelaInicialJogos()),
                      );
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Entrar',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                //Links de texto abaixo do botão
                _buildRichTextLink(
                  'Não tem uma conta? ',
                  'Crie aqui',
                      () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaCriarConta()));
                  },
                  laranja,
                  cinza,
                ),
                const SizedBox(height: 12),
                _buildRichTextLink(
                  'Esqueceu a senha? ',
                  'Recupere aqui',
                      () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaRecuperarSenha()));
                  },
                  laranja,
                  cinza,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}