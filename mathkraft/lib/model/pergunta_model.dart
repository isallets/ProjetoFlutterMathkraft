import 'dart:convert';

class Pergunta {
  final int? id;
  final String conta;
  final String respostaCorreta;
  final String resposta2;
  final String resposta3;
  final String resposta4;

  const Pergunta({
    this.id,
    required this.conta,
    required this.respostaCorreta,
    required this.resposta2,
    required this.resposta3,
    required this.resposta4,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'conta': conta,
      'respostaCorreta': respostaCorreta,
      'resposta2': resposta2,
      'resposta3': resposta3,
      'resposta4': resposta4,
    };
  }

  factory Pergunta.fromMap(Map<String, dynamic> map) {
    return Pergunta(
      id: map['id'] != null ? map['id'] as int : null,
      conta: map['conta'] as String,
      respostaCorreta: map['respostaCorreta'] as String,
      resposta2: map['resposta2'] as String,
      resposta3: map['resposta3'] as String,
      resposta4: map['resposta4'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pergunta.fromJson(String source) =>
      Pergunta.fromMap(json.decode(source) as Map<String, dynamic>);
}
