import 'dart:convert';

class User {
  final int ?id;
  final String nome;
  final String senha;
  final String telefone;
  final int ?pontuacao;
  final int ?ofensitvaCount;
  

  const User({this.id, required this.nome, required this.senha, required this.telefone, this.pontuacao, this.ofensitvaCount});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'senha': senha,
      'telefone': telefone,
      'pontuacao': pontuacao ?? 0,
      'ofensiva_count': pontuacao ?? 1,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['nome'] as String,
      senha: map['senha'] as String,
      telefone: map['telefone'] as String,
      pontuacao: map['pontuacao'] as int,
      ofensitvaCount: map ['ofensiva_count'] as int
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => 
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}