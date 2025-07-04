import 'package:flutter/material.dart';
import 'dart:async';

class TelaCriarConta extends StatelessWidget {
  const TelaCriarConta({super.key});

  @override
  Widget build(BuildContext context) {
    const Color laranja = Color.fromRGBO(249, 206, 79, 1);
    const Color cinza = Color(0xFF424242);

    void _showSuccessDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // Após 2 segundos, o dialog e a tela de cadastro são fechados
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

    return Scaffold(
      backgroundColor: Colors.white,
      // Barra superior com botão de voltar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: cinza),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              Image.asset('lib/assets/MathKraft.png',
                height: 120,
              ),
              const SizedBox(height: 30),

              // "Crie uma conta!"
              const Text(
                'Crie uma conta!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: cinza,
                ),
              ),
              const SizedBox(height: 40),

              // Campos de Texto
              _buildTextField(
                labelText: 'Nome de usuário',
                icon: Icons.person_outline,
                borderColor: cinza,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                labelText: 'Senha',
                icon: Icons.lock_outline,
                obscureText: true,
                borderColor: cinza,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                labelText: 'Repita a senha',
                icon: Icons.lock_outline,
                obscureText: true,
                borderColor: cinza,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                labelText: 'Telefone',
                icon: Icons.phone_iphone_outlined,
                keyboardType: TextInputType.phone,
                borderColor: cinza,
              ),
              const SizedBox(height: 40),

              //Botão de Cadastro
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: laranja,
                  foregroundColor: cinza,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  elevation: 0,
                ),
                onPressed: _showSuccessDialog,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Criar conta',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // View de Sucesso
  Widget _buildSuccessView() {
    return const Column(
      key: ValueKey('successView'),
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Text(
          'Conta criada\ncom sucesso!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Icon(Icons.check, color: Colors.black, size: 80),
        SizedBox(height: 20),
      ],
    );
  }

  // Widget auxiliar para criar os campos de texto padronizados
  Widget _buildTextField({
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required Color borderColor,
  }) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.grey),
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
      ),
    );
  }
}