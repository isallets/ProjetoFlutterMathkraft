import 'package:flutter/material.dart';
import 'package:mathkraft/frontend/widgets/menu_navigation_bar_widget.dart';
import 'package:mathkraft/frontend/screens/tela_criar_pergunta.dart';

class TelaAdmin extends StatefulWidget {
  const TelaAdmin({super.key});

  @override
  State<TelaAdmin> createState() => _TelaAdminState();
}

class _TelaAdminState extends State<TelaAdmin> {
  @override
  Widget build(BuildContext context) {
    const Color verde = Color.fromRGBO(224, 255, 255, 1);
    const Color rosa = Color.fromRGBO(252, 228, 236, 1);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MathKraft',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Image.asset('lib/assets/MathKraft.png', height: 100),
                ],
              ),

              const SizedBox(height: 90),

              const Text(
                'Escolha uma opção:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 30),

              // Botões de Ação
              _buildAdminButton(
                text: 'CRIAR PERGUNTAS',
                buttonColor: verde,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaCriarPergunta()));
                },
              ),
              const SizedBox(height: 40),
              _buildAdminButton(
                text: 'CONSULTAR PERGUNTAS',
                buttonColor: verde,
                onPressed: () {
                  //
                },
              ),
              const SizedBox(height: 40),
              _buildAdminButton(
                text: 'CONSULTAR USUÁRIOS',
                buttonColor: rosa,
                onPressed: () {
                  //
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: menuBottomNavigationBar(context, 0),
    );
  }

  // Widget auxiliar para criar os botões
  Widget _buildAdminButton({
    required String text,
    required Color buttonColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 35.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          ),
          side: const BorderSide(color: Colors.black, width: 2.0),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}