import 'package:flutter/material.dart';
import 'package:mathkraft/validators/validators.dart'; // Importado do seu código
import 'dart:async';
import 'package:mathkraft/widgets/app_bar_voltar_button.dart';

class TelaEditarConta extends StatefulWidget {
  const TelaEditarConta({super.key});

  @override
  State<TelaEditarConta> createState() => _TelaEditarContaState();
}

class _TelaEditarContaState extends State<TelaEditarConta> {
  late TextEditingController _nomeUsuarioController;
  late TextEditingController _telefoneController;

  final Color _corBotao = const Color.fromRGBO(204, 238, 243, 1.0); // Um tom de azul claro do design
  final Color _corTextoBotao = Colors.black;
  final Color _cinza = const Color(0xFF424242);
  late Validators _validators;

  @override
  void initState() {
    super.initState();
    _nomeUsuarioController = TextEditingController();
    _telefoneController = TextEditingController();
    _validators = Validators(); // Inicializa Validators
  }

  @override
  void dispose() {
    _nomeUsuarioController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: _buildSuccessView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppBarVoltarButton voltarButton = AppBarVoltarButton();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: voltarButton.criar(context, Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset('lib/assets/MathKraft.png', height: 100.0),
              const SizedBox(height: 30),

              // Título "Editar Conta"
              const Text(
                'Editar Conta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),

              // Campo Nome de Usuário
              _buildTextField(
                controller: _nomeUsuarioController,
                labelText: 'Nome de usuário',
                icon: Icons.person_outline,
                borderColor: _cinza,
              ),
              const SizedBox(height: 20),

              // Campo Telefone
              _buildTextField(
                controller: _telefoneController,
                labelText: 'Telefone',
                icon: Icons.phone_iphone_outlined,
                keyboardType: TextInputType.phone,
                borderColor: _cinza,
              ),
              const SizedBox(height: 40),

              // Botão "Alterar Senha"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _corBotao,
                    foregroundColor: _corTextoBotao,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                      side: const BorderSide(color: Colors.black, width: 2.0), // Borda preta
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Alterar Senha',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Botão "Salvar Alterações"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    _showSuccessDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _corBotao,
                    foregroundColor: _corTextoBotao,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                      side: const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Salvar Alterações',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSuccessView() {
    return const Column(
      key: ValueKey('successView'),
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Text(
          'Conta alterada\ncom sucesso!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Icon(Icons.check, color: Colors.black, size: 80),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Color borderColor = Colors.black,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade800, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      ),
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
    );
  }
}