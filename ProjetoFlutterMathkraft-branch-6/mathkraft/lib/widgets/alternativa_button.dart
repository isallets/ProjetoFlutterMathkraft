import 'package:flutter/material.dart';
import 'package:mathkraft/dialogs/resposta_dialog.dart';

class AlternativaButton {
  
  RespostaDialog respostaDialog = RespostaDialog();

  Expanded criar(String option, String correctAnswer, context){
    return Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (option == correctAnswer) {
                            respostaDialog.exibir(context);
                          } else {
                            respostaDialog.exibir(context, selectedAnswer: option);
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
                          option,
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
  }
}