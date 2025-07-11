import 'package:flutter/material.dart';
import 'package:mathkraft/screens/tela_buscar_todos_usuarios.dart';
import 'package:mathkraft/widgets/header_mathkraft.dart';
import 'package:mathkraft/widgets/menu_navigation_bar_widget.dart';

class TelaBuscarUsuario extends StatelessWidget {
  const TelaBuscarUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MathKraftHeader(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Buscar usuário:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 100),

            // Campo Nome:
            const Text(
              'Nome:',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8), // Espaço entre o label e o TextField
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder( // Borda do campo de texto
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                enabledBorder: OutlineInputBorder( // Borda quando o campo está habilitado
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                focusedBorder: OutlineInputBorder( // Borda quando o campo está focado
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              ),
              cursorColor: Colors.black, // Cor do cursor
              style: TextStyle(color: Colors.black), // Cor do texto digitado
            ),
            const SizedBox(height: 20), // Espaço entre os campos de texto

            // Campo ID:
            const Text(
              'ID:',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 8), // Espaço entre o label e o TextField
            const TextField(
              keyboardType: TextInputType.number, // Sugere teclado numérico para ID
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              ),
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
            ),

            const Spacer(), // Ocupa todo o espaço disponível, empurrando o botão para baixo

            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const TelaBuscarTodosUsuarios()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[100], // Cor de fundo amarela clara
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    elevation: 0,
                  ),
                  child: const Text(
                    'BUSCAR TODOS',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Botão BUSCAR
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7, // Mesma largura do botão "VOLTAR"
                child: ElevatedButton(
                  onPressed: () {
                    // Ação ao pressionar o botão BUSCAR
                    print('Botão BUSCAR pressionado!');
                    // Implemente sua lógica de busca aqui
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[100], // Cor de fundo do botão (amarelo claro)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Borda arredondada
                      side: const BorderSide(color: Colors.black, width: 1.0), // Borda preta
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    elevation: 0,
                  ),
                  child: const Text(
                    'BUSCAR',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Espaço acima da linha separadora inferior
            const Divider(height: 1, thickness: 1.0, color: Colors.black), // Linha separadora
          ],
        ),
      ),

      // --- Seu Widget de Bottom Navigation Bar ---
      bottomNavigationBar: menuBottomNavigationBar(context, 1), // O índice pode variar dependendo de qual ícone deve estar ativo
      // --- Fim do seu Widget de Bottom Navigation Bar ---
    );
  }
}