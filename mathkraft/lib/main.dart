import 'package:flutter/material.dart';
import 'package:mathkraft/frontend/screens/tela_boas_vindas.dart'; // Importe a tela_boas_vindas

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MathKraft', // Título do seu aplicativo
      theme: ThemeData(
        primarySwatch: Colors.blue, // Você pode ajustar esta cor base
        // fontFamily: 'Montserrat', // Descomente se você estiver usando uma fonte personalizada e a configurou no pubspec.yaml
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TelaBoasVindas(), // Define a TelaBoasVindas como a tela inicial do aplicativo
      debugShowCheckedModeBanner: false, // Remove a faixa de "DEBUG" no canto superior direito
    );
  }
}