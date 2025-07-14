import 'package:flutter/material.dart';
import 'package:mathkraft/controller/user_controller.dart';
import 'package:mathkraft/dialogs/resposta_dialog.dart';
import 'package:mathkraft/model/user_model.dart';

class AlternativaButton {
  
  RespostaDialog respostaDialog = RespostaDialog();
  User ?user = UserController.instance.currentUser;

  Expanded criar(String option, String correctAnswer, context, bool onlyView){
    return Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if(!onlyView){
                            if (option == correctAnswer) {
                              respostaDialog.exibir(context, ofensiva: user!.ofensitvaCount!);
                              UserController.instance.updateUser(
                                User(
                                  id: user!.id,
                                  nome: user!.nome, 
                                  senha: user!.senha, 
                                  telefone: user!.telefone,
                                  pontuacao: (user!.pontuacao !+ user!.ofensitvaCount!),
                                  ofensitvaCount: (user!.ofensitvaCount! + 1)
                                )
                              );
                            } else {
                              respostaDialog.exibir(context, selectedAnswer: option);
                              UserController.instance.updateUser(
                                User(
                                  id: user!.id,
                                  nome: user!.nome, 
                                  senha: user!.senha, 
                                  telefone: user!.telefone,
                                  pontuacao: user!.pontuacao,
                                  ofensitvaCount: 1
                                )
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFAEC6DE),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          option,
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
  }
}