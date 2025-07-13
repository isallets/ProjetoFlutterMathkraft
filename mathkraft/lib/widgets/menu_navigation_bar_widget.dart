import 'package:flutter/material.dart';
import 'package:mathkraft/controller/user_controller.dart';
import 'package:mathkraft/screens/tela_admin.dart';
import 'package:mathkraft/screens/tela_perfil.dart';
import 'package:mathkraft/screens/tela_inicial_jogos.dart';

Widget menuBottomNavigationBar(BuildContext context, int selectedIndex) {
  late bool admin;

  Future<void> verificaTipo() async{
    admin = await UserController.instance.ehAdmin();
  }
  
  verificaTipo();

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
        if(!admin){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaInicialJogos()));
        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaAdmin()));
        }
      }
      else if (index == 1){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaPerfil()));
      }
    },
  );
}