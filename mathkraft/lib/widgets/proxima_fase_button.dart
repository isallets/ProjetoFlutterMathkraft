import 'package:flutter/material.dart';
import 'package:mathkraft/controller/pergunta_controller.dart';
import 'package:mathkraft/screens/tela_jogo.dart';

class ProximaFaseButton {
  SizedBox exibir (context, dialogContext){
    return SizedBox(
                  width: 170.0,
                  child: ElevatedButton(
                    onPressed: () {
                      PerguntaController.instance.sortearPergunta();
                      Navigator.of(dialogContext).pop();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TelaJogo()));
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
                );
  }
}