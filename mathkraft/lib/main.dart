import 'package:flutter/material.dart';
import 'package:mathkraft/repository/user_repository.dart';
import 'package:mathkraft/screens/tela_boas_vindas.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  UserRepository.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      title: 'MathKraft',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TelaBoasVindas(),
      debugShowCheckedModeBanner: false, // Remove a faixa de "DEBUG" no canto superior direito
    );
  }
}