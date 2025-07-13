import 'dart:developer';

import 'package:mathkraft/dao/pergunta_dao.dart';
import 'package:mathkraft/model/pergunta.dart';

class PerguntaRepository {
  static final PerguntaRepository instance = PerguntaRepository();

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
}