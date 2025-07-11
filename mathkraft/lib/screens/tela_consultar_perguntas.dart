import 'package:flutter/material.dart';
import 'package:mathkraft/widgets/header_mathkraft.dart';
import 'package:mathkraft/widgets/admin_menu_navigation_bar_widget.dart';
import 'package:mathkraft/screens/tela_editar_pergunta.dart';

class QuestionListItem extends StatelessWidget {
  final String question;
  final VoidCallback onDelete;

  const QuestionListItem({
    super.key,
    required this.question,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              question,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  print('Ver detalhes de $question');
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.black),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaEditarPergunta()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.black),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TelaConsultarPerguntas extends StatefulWidget {
  const TelaConsultarPerguntas({super.key});

  @override
  State<TelaConsultarPerguntas> createState() => _TelaConsultarPerguntasState();
}

class _TelaConsultarPerguntasState extends State<TelaConsultarPerguntas> {
  final List<String> _questions = [
    'Pergunta 1: Qual é a raiz quadrada de 9?',
    'Pergunta 2: Quanto é 5 + 3 * 2?',
    'Pergunta 3: Se x = 2 e y = 3, qual o valor de 2x + y?',
  ];

  Widget _buildDialogButton({
    required BuildContext context,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
            side: const BorderSide(color: Colors.black, width: 1.0),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // --- AlertDialog de Confirmação de Exclusão de Pergunta ---
  void _showExcluirPerguntaDialog(String perguntaParaExcluir) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: SizedBox(
            height: 250.0,
            width: 280.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Deseja excluir esta pergunta?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '"$perguntaParaExcluir"',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),

                Column(
                  children: [
                    _buildDialogButton(
                      context: dialogContext, // OK, o parâmetro agora é esperado
                      text: 'CANCELAR',
                      backgroundColor: Colors.pink[50]!,
                      textColor: Colors.black,
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        print('Exclusão de pergunta cancelada.');
                      },
                    ),
                    const SizedBox(height: 15.0),

                    _buildDialogButton(
                      context: dialogContext, // OK, o parâmetro agora é esperado
                      text: 'CONFIRMAR',
                      backgroundColor: Colors.red[100]!,
                      textColor: Colors.red[900]!,
                      onPressed: () {
                        setState(() {
                          _questions.remove(perguntaParaExcluir);
                        });
                        Navigator.of(dialogContext).pop();
                        print('Pergunta "$perguntaParaExcluir" excluída!');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(color: Colors.black, width: 2.0),
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }

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
                child: ListView.separated(
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    final String questionText = _questions[index];
                    return QuestionListItem(
                      question: questionText,
                      onDelete: () {
                        _showExcluirPerguntaDialog(questionText);
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
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
      bottomNavigationBar: adminMenuBottomNavigationBar(context, 1),
    );
  }
}
