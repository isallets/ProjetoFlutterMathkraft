import 'package:flutter/material.dart';
import 'package:mathkraft/screens/tela_perfil.dart';
import 'package:mathkraft/screens/tela_inicial_jogos.dart';

Widget menuBottomNavigationBar(BuildContext context, int selectedIndex) {

  return Column(
    children: [
      Container(
        width: 380.0,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.house,
                size: 45.0,
                color: Colors.black, 
              ),
              onPressed: () {
                if (selectedIndex != 0) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaInicialJogos()));
                }
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                size: 45.0,
                color: Colors.black,
              ),
              onPressed: () {
                if (selectedIndex != 1) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaPerfil()));
                }
              },
            ),
          ],
        ),
      ),
    ],
  );
}