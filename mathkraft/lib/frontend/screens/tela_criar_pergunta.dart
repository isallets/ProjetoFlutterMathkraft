import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mathkraft/frontend/widgets/menu_navigation_bar_widget.dart';

class TelaCriarPergunta extends StatefulWidget {
  const TelaCriarPergunta({super.key});

  @override
  State<TelaCriarPergunta> createState() => _TelaCriarPerguntaState();
}

class _TelaCriarPerguntaState extends State<TelaCriarPergunta> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _SucessoDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Timer(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        });

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: _buildSucesso(),
        );
      },
    );
  }

  Widget _buildSucesso() {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          Text(
            'Pergunta criada\ncom sucesso!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Icon(Icons.check, color: Colors.black, size: 80),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color verde = Color.fromRGBO(224, 255, 255, 1);
    const Color preto = Colors.black;

    return Scaffold(
      backgroundColor: Colors.white,
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
              icon: const Icon(Icons.arrow_back, color: preto),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'MathKraft',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: preto),
                  ),
                  Image.asset('lib/assets/MathKraft.png', height: 100),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Crie uma questão:',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: preto),
              ),
              const SizedBox(height: 20),

              _buildLabeledTextField(label: 'Questão:', hintText: 'Ex.: 12 x 5'),
              const SizedBox(height: 24),
              _buildLabeledTextField(label: 'Resposta Correta:', hintText: 'Ex.: 60'),
              const SizedBox(height: 24),
              _buildLabeledTextField(label: 'Respostas Erradas:', hintText: 'Ex.: 57'),
              const SizedBox(height: 16),
              _buildLabeledTextField(hintText: 'Ex.: 62'),
              const SizedBox(height: 16),
              _buildLabeledTextField(hintText: 'Ex.: 65'),
              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: verde,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
                    side: const BorderSide(color: Colors.black, width: 2.0),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  ),
                  onPressed: _SucessoDialog,
                  child: const Text(
                    'CRIAR PERGUNTA',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: menuBottomNavigationBar(context, 0),
    );
  }

  Widget _buildLabeledTextField({String? label, required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}