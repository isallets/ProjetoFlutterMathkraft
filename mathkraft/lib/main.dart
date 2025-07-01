import 'package:flutter/material.dart';
import 'package:mathkraft/screens/tela_inicial_jogos.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MathKraft',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: TelaInicialJogos(), 
      debugShowCheckedModeBanner: false,
    );
  }
}