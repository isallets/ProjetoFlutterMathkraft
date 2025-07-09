import 'package:flutter/material.dart';
import 'package:mathkraft/frontend/screens/tela_perfil.dart';
import 'package:mathkraft/frontend/screens/tela_inicial_jogos.dart';

Widget menuBottomNavigationBar(BuildContext context, int selectedIndex) {
  return BottomNavigationBar(
    currentIndex: selectedIndex,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.black,
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    elevation: 0,

    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.house, size: 45.0),
        label: ''
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person, size: 45.0),
        label: ''
      ),
    ],
    onTap: (index) {
      if (index == 0) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaInicialJogos()));
      }
      else if (index == 1){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaPerfil()));
      }
    },
  );
}