import 'package:flutter/material.dart';
import 'package:mathkraft/controller/pergunta_controller.dart';
import 'package:mathkraft/model/pergunta_model.dart';
import 'package:mathkraft/widgets/alternativa_button.dart';
import 'package:mathkraft/widgets/app_bar_voltar_button.dart';
import 'package:mathkraft/dialogs/resposta_dialog.dart';

class TelaJogo extends StatefulWidget {
  final Pergunta ?perguntaParaView; 
  const TelaJogo({super.key, this.perguntaParaView});


  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  final List<String> options = [];
  late String correctAnswer;
  final RespostaDialog respostaDialog = RespostaDialog();
  final AlternativaButton alternativa = AlternativaButton();
  final AppBarVoltarButton voltarButton = AppBarVoltarButton();
  Pergunta ?pergunta = PerguntaController.instance.currentPergunta;
  late List<String> operandos;
  bool onlyView = false;

  void _splitPergunta() {
    if(widget.perguntaParaView != null){
      pergunta = widget.perguntaParaView!;
      onlyView = true;
    }
    operandos = pergunta!.conta.split(' ');
    //adicionando opcoes da pergunta atual
    options.add(pergunta!.respostaCorreta);
    options.add(pergunta!.resposta2);
    options.add(pergunta!.resposta3);
    options.add(pergunta!.resposta4);
    options.shuffle();
    correctAnswer = pergunta!.respostaCorreta;
  }


  @override
  Widget build(BuildContext context) {
    _splitPergunta();
    return Scaffold(
      backgroundColor: const Color(0xFFE0FFFF),
      appBar: voltarButton.criar(context, const Color(0xFFE0FFFF)),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 150),

          //Pergunta
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '${operandos[0]} ',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  operandos[1],
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.deepOrange,
                  ),
                ),
                Text(
                  ' ${operandos[2]} ',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  operandos[3],
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.deepOrange,
                  ),
                ),
                Text(
                  ' ${operandos[4]} = ',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                Container(
                  width: 85,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFAEC6DE),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 250),

          //Botões de Resposta
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botão 1
                    alternativa.criar(options[0], correctAnswer, context, onlyView),
                    const SizedBox(width: 20),

                    // Botão 2
                    alternativa.criar(options[1], correctAnswer, context, onlyView),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botão 3
                    alternativa.criar(options[2], correctAnswer, context, onlyView),
                    const SizedBox(width: 20),

                    // Botão 4
                    alternativa.criar(options[3], correctAnswer, context, onlyView),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}