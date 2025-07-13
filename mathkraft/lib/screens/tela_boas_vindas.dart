import 'package:flutter/material.dart';
import 'package:mathkraft/controller/user_controller.dart';
import 'package:mathkraft/screens/tela_criar_conta.dart';
import 'package:mathkraft/screens/tela_recuperar_senha.dart';

class TelaBoasVindas extends StatefulWidget {
  const TelaBoasVindas({super.key});

  @override
  State<TelaBoasVindas> createState() => _TelaBoasVindasState();
}

class _TelaBoasVindasState extends State<TelaBoasVindas> {
  final _nomeController = TextEditingController();
  final _senhaController = TextEditingController();

  final Color laranja = Colors.orange;
  final Color preto = Colors.black;
  final Color cinza = const Color(0xFF424242);

  void _logar(String nome, String senha) async{
    await UserController.instance.login(
      context,
      _nomeController.text,
      _senhaController.text,
    );
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
                    _logar(
                      _nomeController.text,
                      _senhaController.text
                      );
                    

                    
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