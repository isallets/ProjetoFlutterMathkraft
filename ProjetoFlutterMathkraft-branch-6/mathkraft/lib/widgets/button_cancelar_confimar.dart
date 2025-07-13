import 'package:flutter/material.dart';

//função para construir o botão de CANCELAR do AlertDialog
Widget buildCancelarButton({required BuildContext context, required VoidCallback onPressed}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed, 
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(252, 228, 236, 1),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
          side: BorderSide(color: Colors.black, width: 2.0),
        ),
        foregroundColor: Colors.black,
      ),
      child: Text(
        'CANCELAR ',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ),
  );
}

//função para construir o botão de CONFIRMAR do AlertDialog
Widget buildConfirmarButton({required BuildContext context, required VoidCallback onPressed}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 243, 122, 85),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0), 
          side: BorderSide(color: Colors.black, width: 2.0),
        ),
        foregroundColor: Colors.black,
      ),
      child: Text(
        'CONFIRMAR',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black, 
        ),
      ),
    ),
  );
}