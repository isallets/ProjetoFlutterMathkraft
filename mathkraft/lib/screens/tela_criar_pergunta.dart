import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mathkraft/controller/pergunta_controller.dart';
import 'package:mathkraft/model/pergunta_model.dart';
import 'dart:async';
import 'package:mathkraft/widgets/admin_menu_navigation_bar_widget.dart';

class TelaCriarPergunta extends StatefulWidget {
  final Pergunta ?perguntaParaEditar;
  const TelaCriarPergunta({super.key, this.perguntaParaEditar});

  @override
  State<TelaCriarPergunta> createState() => _TelaCriarPerguntaState();
}

class _TelaCriarPerguntaState extends State<TelaCriarPergunta> {
  final _valor1 = TextEditingController();
  final _valor2 = TextEditingController();
  final _valor3 = TextEditingController();
  final _respostaCorretaController = TextEditingController();
  final _resposta2Controller = TextEditingController();
  final _resposta3Controller = TextEditingController();
  final _resposta4Controller = TextEditingController();
  List<String> opcoes = ['+', '-', '*', '/'];
  String valorDropDown1 = '+';
  String valorDropDown2 = '+';
  List<DropdownMenuEntry<String>> menuEntries = UnmodifiableListView<DropdownMenuEntry<String>>(
    ['+', '-', '*', '/'].map<DropdownMenuEntry<String>>((String name) => DropdownMenuEntry<String>(value: name, label: name)),
  );
  String titulo = 'Crie uma questão';
  String botaoText = 'CRIAR PERGUNTA';
  String mensagem = 'Pergunta Criada\ncom suceso!!!';

  @override
  void initState() {
    super.initState();
    if(widget.perguntaParaEditar != null){
      _valor1.text = widget.perguntaParaEditar!.conta.split(' ')[0];
      _valor2.text = widget.perguntaParaEditar!.conta.split(' ')[2];
      _valor3.text = widget.perguntaParaEditar!.conta.split(' ')[4];
      _respostaCorretaController.text = widget.perguntaParaEditar!.respostaCorreta;
      _resposta2Controller.text = widget.perguntaParaEditar!.resposta2;
      _resposta3Controller.text = widget.perguntaParaEditar!.resposta3;
      _resposta4Controller.text = widget.perguntaParaEditar!.resposta4;
      titulo = 'Edite a questão';
      botaoText = 'SALVAR ALTERAÇÕES';
      mensagem = 'Pergunta alterada\n com sucesso!!!';
    }
  }


  void _sucessoDialog() {
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

  _criarPergunta() async {
    List<String> campos = [
                      _valor1.text,
                      _valor2.text,
                      _valor3.text,
                      _respostaCorretaController.text,
                      _resposta2Controller.text,
                      _resposta3Controller.text,
                      _resposta4Controller.text
                    ];
                    for(int i = 0; i<7; i++){
                      if(campos[i].isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Por favor, preencha todos os campos.')),
                        );
                        return;
                      }
                      if(i>2 && i<6){
                        for(int j = i+1; j<5; j++){
                          if(campos[i] == campos[j]) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Existem resposta iguais!!!')),
                            );
                            return;
                          }
                        }
                      }
                    }
                    if(widget.perguntaParaEditar != null){
                      final Pergunta perguntaNova = Pergunta(
                        id: widget.perguntaParaEditar!.id,
                        conta: '${campos[0]} $valorDropDown1 ${campos[1]} $valorDropDown2 ${campos[2]}', 
                        respostaCorreta: campos[1], 
                        resposta2: campos[2], 
                        resposta3: campos[3], 
                        resposta4: campos[4]);
                      await PerguntaController.instance.updatePergunta(perguntaNova);
                    }
                    else{
                      await PerguntaController.instance.createPergunta('${campos[0]} $valorDropDown1 ${campos[1]} $valorDropDown2 ${campos[2]}', campos[3], campos[4], campos [5], campos[6]);
                    }
                    _sucessoDialog();
  }

  Widget _buildSucesso() {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          Text(
            mensagem,
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
              Text(
                titulo,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: preto),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildLabeledTextField(label: 'Valor 1', hintText: '', controller: _valor1)
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownMenu<String>(
                        initialSelection: opcoes[0],
                        onSelected: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            valorDropDown1 = value!;
                          });
                        },
                        dropdownMenuEntries: menuEntries,
                      ),
                    ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildLabeledTextField(label: 'Valor 2', hintText: '', controller: _valor2)
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownMenu<String>(
                      initialSelection: opcoes[0],
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          valorDropDown2 = value!;
                        });
                      },
                      dropdownMenuEntries: menuEntries,
                    )
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildLabeledTextField(label: 'Valor 3', hintText: 'Ex.: 60', controller: _valor3)
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildLabeledTextField(label: 'Resposta Correta:', hintText: 'Ex.: 60', controller: _respostaCorretaController),
              const SizedBox(height: 24),
              _buildLabeledTextField(label: 'Respostas Erradas:', hintText: 'Ex.: 57', controller: _resposta2Controller),
              const SizedBox(height: 16),
              _buildLabeledTextField(hintText: 'Ex.: 62', controller: _resposta3Controller),
              const SizedBox(height: 16),
              _buildLabeledTextField(hintText: 'Ex.: 65', controller: _resposta4Controller),
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
                  onPressed: _criarPergunta,
                  child: Text(
                    botaoText,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: adminMenuBottomNavigationBar(context, 0),
    );
  }

  Widget _buildLabeledTextField({String? label, required String hintText, required TextEditingController controller}) {
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
          controller: controller,
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