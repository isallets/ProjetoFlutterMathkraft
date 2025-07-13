import 'dart:developer';

import 'package:mathkraft/dao/pergunta_dao.dart';
import 'package:mathkraft/model/pergunta_model.dart';

class PerguntaRepository {
  static final PerguntaRepository instance = PerguntaRepository._();

  PerguntaRepository._(){
    _criaPerguntas();
  }

  Future<Pergunta?> addPergunta(String conta, String respostaCorreta, String resposta2, String resposta3, String resposta4) async {
    final existePergunta = await PerguntaDAO.getByPergunta(conta);

    if (existePergunta != null) {
      log('Pergunta já existe!');
      return null; 
    }
    final novaPergunta = Pergunta(conta: conta, respostaCorreta: respostaCorreta, resposta2: resposta2, resposta3: resposta3, resposta4: resposta4);
    await PerguntaDAO.inserir(novaPergunta);
    return novaPergunta;
  }

  void _criaPerguntas() async {
    final List<Pergunta> perguntas = await PerguntaDAO.carregarPergunta();

    if(perguntas.isEmpty){
      var pergunta1 = Pergunta(conta: '6 / 3 + 15', respostaCorreta: '17', resposta2: '19', resposta3: '3', resposta4: '18');
      var pergunta2 = Pergunta(conta: '10 + 2 / 2', respostaCorreta: '11', resposta2: '6', resposta3: '12', resposta4: '20');
      var pergunta3 = Pergunta(conta: '30 - 15 / 3', respostaCorreta: '25', resposta2: '5', resposta3: '10', resposta4: '5');
      log('Criando Perguntas');
      await PerguntaDAO.inserir(pergunta1);
      await PerguntaDAO.inserir(pergunta2);
      await PerguntaDAO.inserir(pergunta3);
    }
  }

  Future<List<Pergunta>> getAllPergunta() async {
    return await PerguntaDAO.carregarPergunta();
  }
  
  Future<void> deletePergunta(int id) async {
    await PerguntaDAO.deletar(id);
  }

  Future<void> updatePergunta(Pergunta pergunta) async {
    await PerguntaDAO.atualizar(pergunta);
  }

  Future<Pergunta?> getPerguntaById(int id) async {
    return await PerguntaDAO.getById(id);
  }

  Future<Pergunta?> getPerguntaByConta(String conta) async {
    return await PerguntaDAO.getByPergunta(conta);
  }

  Future<int> getLength() async{
    final List<Pergunta> listaPerguntas = await getAllPergunta();
    return listaPerguntas.length;
  }
}