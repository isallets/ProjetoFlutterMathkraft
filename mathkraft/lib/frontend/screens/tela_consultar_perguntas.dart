import 'package:flutter/material.dart';
import 'package:mathkraft/frontend/widgets/header_mathkraft.dart';
import 'package:mathkraft/frontend/widgets/menu_navigation_bar_widget.dart';
import 'package:mathkraft/frontend/screens/tela_editar_pergunta.dart';

class TelaConsultarPerguntas extends StatelessWidget {
  const TelaConsultarPerguntas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MathKraftHeader(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Perguntas:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  // Lista de perguntas
                  children: const [
                    QuestionListItem(question: 'Pergunta 1'),
                    QuestionListItem(question: '...'),
                    QuestionListItem(question: '...'),
                    QuestionListItem(question: '...'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[50],
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

      bottomNavigationBar: menuBottomNavigationBar(context, 1),
    );
  }
}

// Widget auxiliar para cada item da lista de pergunta (provavelmente vai mudar)
class QuestionListItem extends StatelessWidget {
  final String question;

  const QuestionListItem({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  // Ação para o ícone de lupa
                  print('Buscar $question');
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.black),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaEditarPergunta()));
                  print('Editar $question');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
