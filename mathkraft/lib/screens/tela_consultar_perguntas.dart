import 'package:flutter/material.dart';
import 'package:mathkraft/controller/pergunta_controller.dart';
import 'package:mathkraft/model/pergunta_model.dart';
import 'package:mathkraft/screens/tela_criar_pergunta.dart';
import 'package:mathkraft/screens/tela_jogo.dart';
import 'package:mathkraft/widgets/header_mathkraft.dart';
import 'package:mathkraft/widgets/admin_menu_navigation_bar_widget.dart';


class TelaConsultarPerguntas extends StatefulWidget {
  const TelaConsultarPerguntas({super.key});

  @override
  State<TelaConsultarPerguntas> createState() => _TelaConsultarPerguntasState();
}

class _TelaConsultarPerguntasState extends State<TelaConsultarPerguntas> {
  late List<Pergunta> _perguntas = [];

  @override
  void initState() {
    super.initState();
    _listarPerguntas();
  }

  Future<void> _listarPerguntas() async {
    final listaDePerguntas = await PerguntaController.instance.getAllPergunta();
        setState(() {
        _perguntas = listaDePerguntas;
      });
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
                  itemCount: _perguntas.length,
                  itemBuilder: (context, index) {
                    return PerguntaListItem(
                      pergunta: _perguntas[index],
                      onActionCompleted: _listarPerguntas,
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

class PerguntaListItem extends StatelessWidget {
  final Pergunta pergunta;
  final VoidCallback onActionCompleted; // "Avisa" a tela para recarregar a lista

  const PerguntaListItem({
    super.key,
    required this.pergunta,
    required this.onActionCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(pergunta.conta, style: const TextStyle(fontSize: 20)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () async {
                  await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaJogo(perguntaParaView: pergunta)));
                  print('Ver detalhes de $pergunta');
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.black),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaCriarPergunta(perguntaParaEditar: pergunta)),
                  );
                  // Quando voltar da tela de edição, recarrega a lista
                  onActionCompleted();
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _showDeleteDialog(context, pergunta, onActionCompleted),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  // A lógica do dialog de deletar
  void _showDeleteDialog(BuildContext context, Pergunta pergunta, VoidCallback onActionCompleted) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Tem certeza que deseja excluir a pergunta ${pergunta.conta}?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              await PerguntaController.instance.deletePergunta(pergunta.id!);
              Navigator.of(context).pop();
              // Avisa a tela principal para recarregar a lista
              onActionCompleted();
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
