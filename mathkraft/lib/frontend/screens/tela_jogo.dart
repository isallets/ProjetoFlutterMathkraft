import 'package:flutter/material.dart';
import 'package:mathkraft/frontend/widgets/alternativa_button.dart';
import 'package:mathkraft/frontend/widgets/app_bar_voltar_button.dart';
import 'package:mathkraft/frontend/dialogs/resposta_dialog.dart';


class TelaJogo extends StatefulWidget {
  const TelaJogo({super.key});

  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  final String question = '3 * 7 + 2 =';
  final List<String> options = ['32', '23', '26', '30'];
  final String correctAnswer = '23';
  final RespostaDialog respostaDialog = RespostaDialog();
  final AlternativaButton alternativa = AlternativaButton();
  final AppBarVoltarButton voltarButton = AppBarVoltarButton();

  @override
  Widget build(BuildContext context) {
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
                const Text(
                  '3 ',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  '*',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.deepOrange,
                  ),
                ),
                const Text(
                  ' 7 ',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  '+',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.deepOrange,
                  ),
                ),
                const Text(
                  ' 2 = ',
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
                    alternativa.criar(options[0], correctAnswer, context),
                    const SizedBox(width: 20),

                    // Botão 2
                    alternativa.criar(options[1], correctAnswer, context),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botão 3
                    alternativa.criar(options[2], correctAnswer, context),
                    const SizedBox(width: 20),

                    // Botão 4
                    alternativa.criar(options[3], correctAnswer, context),
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