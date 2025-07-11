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

class UserLoginService {
  late UserRepository userRepository;
  static final UserLoginService _instancia = UserLoginService._();
  Validators v = Validators();

//construtor anonimo para impedir instâncias em outras classes
  UserLoginService._(){
    userRepository = UserRepository.instance;
  }

//função para permitir acesso à instância
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

  class TelaBoasVindas extends StatelessWidget {
  const TelaBoasVindas({super.key});

  @override
  Widget build(BuildContext context) {
    const Color laranja = Colors.orange;
    const Color preto = Colors.black;
    const Color cinza = Color(0xFF424242);
    late TextEditingController _nome = TextEditingController();
    late TextEditingController _senha = TextEditingController();
    late var login;
  

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
                    color: preto,
                  ),
                ),
                const SizedBox(height: 16),
                Image.asset('lib/assets/MathKraft.png',
                  height: 150,
                ),
                const SizedBox(height: 48),

                //Campo "Nome de usuário"
                TextField(
                  controller: _nome,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nome de usuário',
                    prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: laranja, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //Campo "Senha"
                TextField(
                  controller: _senha,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: laranja, width: 2),
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
                    login = UserController.instance.logar(_nome.text, _senha.text);
                    if(login.runtimeType == String){
                      showDialog(
                        context: context, 
                        builder: (BuildContext dialogContext){
                          return AlertDialog(
                            backgroundColor: const Color.fromARGB(255, 255, 179, 149),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(login, textAlign: TextAlign.center,),
                              ],
                            ));
                        });
                    }
                    else if(login.runtimeType == UserAdmin){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TelaAdmin()));
                    }
                    else{
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaInicialJogos()));
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaCriarConta()),
                    );
                  },
                  laranja,
                  cinza,
                ),
                const SizedBox(height: 12),
                _buildRichTextLink(
                  'Esqueceu a senha? ',
                  'Recupere aqui',
                      () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const TelaRecuperarSenha()),);
                  },
                  laranja,
                  cinza,
                ),
                const SizedBox(height: 12),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para criar os links com texto formatado
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
}