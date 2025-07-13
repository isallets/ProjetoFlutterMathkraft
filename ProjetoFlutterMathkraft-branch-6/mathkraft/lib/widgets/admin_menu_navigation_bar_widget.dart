import 'package:flutter/material.dart';
import 'package:mathkraft/screens/tela_admin.dart';
import 'package:mathkraft/screens/tela_perfil.dart';

Widget adminMenuBottomNavigationBar(BuildContext context, int selectedIndex) {
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaAdmin()));
      }
      else if (index == 1){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaPerfil()));
      }
    },
  );
}