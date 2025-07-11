import 'package:flutter/material.dart';

class ProximaFaseButton {
  SizedBox exibir (dialogContext){
    return SizedBox(
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
                );
  }
}