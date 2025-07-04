import 'package:flutter/material.dart';

class TelaJogo extends StatefulWidget {
  const TelaJogo({super.key});

  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  final String question = '3 * 7 + 2 =';
  final List<String> options = ['32', '23', '26', '30'];
  final String correctAnswer = '23';

  void _respostaCorretaDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
        barrierColor: Colors.greenAccent.withOpacity(0.8),
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Color(0xFF99FA79),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)),
          content: SizedBox(
            height: 470.0,
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Correto!',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                const Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 80,
                ),

                const SizedBox(height: 20),

                const Text(
                  '+ 1 ponto',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(
                  width: 170.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                        side: const BorderSide(color: Colors.black, width: 2.0),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Próxima fase >',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _respostaIncorretaDialog(String selectedAnswer) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0xFFE47053).withOpacity(0.8),
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFD85B2B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)),
          content: SizedBox(
            height: 470.0,
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Incorreto...',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),

                const Expanded(child: SizedBox()),

                const Text(
                  '0 pontos',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),

                const Expanded(child: SizedBox()),

                SizedBox(
                  width: 185.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                        side: const BorderSide(color: Colors.black, width: 2.0),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tente novamente ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.refresh, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0FFFF),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color(0xFFE0FFFF),
        elevation: 0,
      ),

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

          const SizedBox(height: 300),

          //Botões de Resposta
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botão 1
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (options[0] == correctAnswer) {
                            _respostaCorretaDialog();
                          } else {
                            _respostaIncorretaDialog(options[0]);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFAEC6DE),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          options[0],
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Botão 2
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (options[1] == correctAnswer) {
                            _respostaCorretaDialog();
                          } else {
                            _respostaIncorretaDialog(options[1]);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFAEC6DE),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          options[1],
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botão 3
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (options[2] == correctAnswer) {
                            _respostaCorretaDialog();
                          } else {
                            _respostaIncorretaDialog(options[2]);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFAEC6DE),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          options[2],
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Botão 4
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (options[3] == correctAnswer) {
                            _respostaCorretaDialog();
                          } else {
                            _respostaIncorretaDialog(options[3]);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFAEC6DE),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          options[3],
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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