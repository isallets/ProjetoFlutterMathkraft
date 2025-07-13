import 'package:mathkraft/model/pergunta.dart';
import 'package:mathkraft/repository/pergunta_repository.dart';

class PerguntaController {
  static final PerguntaController instance = PerguntaController._();
  final PerguntaRepository _repository = PerguntaRepository.instance;

  Pergunta? currentPergunta;

  PerguntaController._();

  Future<bool> createPergunta(String conta, String respostaCorreta, String resposta2, String resposta3, String resposta4) async {
    final novaPergunta = await _repository.addPergunta(conta, respostaCorreta, resposta2, resposta3, resposta4);
    return novaPergunta != null; 
  }
  Future<List<Pergunta>> getAllPergunta() {
    return _repository.getAllPergunta();
  }

  Future<void> deletePergunta(int id) {
    return _repository.deletePergunta(id);
  }

  Future<void> updatePergunta(Pergunta pergunta) {
    return _repository.updatePergunta(pergunta);
  }

  Future<Pergunta?> getPerguntaById(int id) {
    return _repository.getPerguntaById(id);
  }

  Future<Pergunta?> getPerguntaByConta(String conta) {
    return _repository.getPerguntaByConta(conta);
  }

  Future<Pergunta?> verificarPergunta(String conta) async {
    final pergunta = await _repository.getPerguntaByConta(conta);

    if (pergunta != null && pergunta.conta == conta) {
      return pergunta;
    }
    return null; 
  }

}