import 'package:flutter/material.dart';
import 'package:mathkraft/widgets/app_bar_voltar_button.dart';

class TelaRecuperarSenha extends StatefulWidget {
  const TelaRecuperarSenha({super.key});

  @override
  State<TelaRecuperarSenha> createState() => _TelaRecuperarSenhaState();
}

class _TelaRecuperarSenhaState extends State<TelaRecuperarSenha> {
  void _showNewPasswordDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const NovaSenhaDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color laranja = Color.fromRGBO(249, 206, 79, 1);
    const Color preto = Colors.black;
    const Color cinza = Color(0xFF424242);
    final AppBarVoltarButton voltarButton = AppBarVoltarButton();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: voltarButton.criar(context, Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Image.asset('lib/assets/MathKraft.png', height: 100),
              const SizedBox(height: 30),
              const Text(
                'Recuperar Senha',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: preto,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Insira seu nome de usuário e os\núltimos 3 dígitos do seu telefone',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: cinza),
              ),
              const SizedBox(height: 40),

              // Campos de Texto
              _buildCampoTexto(
                labelText: 'Nome de usuário',
                icon: Icons.person_outline,
                borderColor: cinza,
              ),
              const SizedBox(height: 20),
              _buildCampoTexto(
                labelText: 'Telefone',
                icon: Icons.phone_iphone_outlined,
                keyboardType: TextInputType.number,
                borderColor: cinza,
              ),
              const SizedBox(height: 40),

              // Botão
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: laranja,
                  foregroundColor: preto,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                ),
                onPressed: _showNewPasswordDialog,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Alterar senha',
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

  // Widget auxiliar para os campos de texto
  Widget _buildCampoTexto({
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required Color borderColor,
  }) {
    return TextField(
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
      ),
    );
  }
}

//Widget para o Dialog de Nova Senha
class NovaSenhaDialog extends StatefulWidget {
  const NovaSenhaDialog({super.key});

  @override
  State<NovaSenhaDialog> createState() => _NovaSenhaDialogState();
}

class _NovaSenhaDialogState extends State<NovaSenhaDialog> {
  bool _ehSenhaNova = false;

  void _mudarPassword() {
    setState(() {
      _ehSenhaNova = true;
    });

    // Após 2 segundos, fecha tudo e volta para a tela de login
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color buttonColor = Color(0xFFFFC107);
    const Color darkTextColor = Color(0xFF212121);
    const Color borderColor = Colors.grey;

    // Conteúdo do Dialog
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: _ehSenhaNova
              ? _buildSucesso()
              : _buildFormulario(),
        ),
      ),
    );
  }

  //Sucesso
  Widget _buildSucesso() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Text(
          'Senha alterada\ncom sucesso!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Icon(Icons.check, color: Colors.black, size: 80),
        SizedBox(height: 20),
      ],
    );
  }

  //Formulário
  Widget _buildFormulario() {
    const Color buttonColor = Color(0xFFFFC107);
    const Color darkTextColor = Color(0xFF212121);
    const Color borderColor = Colors.grey;

    return Column(
      key: const ValueKey('formView'),
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Nova senha',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Senha',
            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Repita a senha',
            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: darkTextColor,
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0),
            ),
          ),
          onPressed: _mudarPassword,
          child: const Text('Alterar senha', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}