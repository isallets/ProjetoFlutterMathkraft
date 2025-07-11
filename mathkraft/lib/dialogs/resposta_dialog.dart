import 'package:flutter/material.dart';
import 'package:mathkraft/widgets/proxima_fase_button.dart';
import 'package:mathkraft/widgets/tente_novamente_button.dart';


class RespostaDialog {
  ProximaFaseButton next = ProximaFaseButton();
  TenteNovamenteButton retry = TenteNovamenteButton();

  SizedBox mensagemCorreto(dialogContext){
    return SizedBox(
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

                next.exibir(dialogContext)
              ]
            )
    );
  }

  SizedBox mensagemIncorreto(dialogContext){
    return SizedBox(
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

                retry.exibir(dialogContext)
              ],
            ),
          );
  }

  //função principal
  void exibir(context, {String ?selectedAnswer}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: selectedAnswer == null ? Colors.greenAccent.withOpacity(0.8) : Color(0xFFE47053).withOpacity(0.8),
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: selectedAnswer == null ? Color(0xFF99FA79) : const Color(0xFFD85B2B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)),
          content: 
          selectedAnswer == null ?
          mensagemCorreto(dialogContext) : mensagemIncorreto(dialogContext)
        );
      },
    );
  }
}