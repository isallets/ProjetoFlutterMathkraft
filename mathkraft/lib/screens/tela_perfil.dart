import 'package:flutter/material.dart';
import 'package:mathkraft/screens/tela_boas_vindas.dart';
import 'package:mathkraft/widgets/menu_navigation_bar_widget.dart';
import 'package:mathkraft/widgets/button_cancelar_confimar.dart';
import 'package:mathkraft/screens/tela_editar_conta.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  _TelaPerfilState createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil>{

  //botão sair da conta
  void _buttonSairContaDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 250.0, 
            width: 300.0,  
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              crossAxisAlignment: CrossAxisAlignment.center, 
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Deseja sair?',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Expanded(child: Container()),
                Column(
                  children: [
                    buildCancelarButton(
                      context: context,
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaPerfil()));
                      },
                    ),

                    SizedBox(height: 15.0),
                    
                    buildConfirmarButton(
                      context: context,
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaBoasVindas()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.black, width: 2.0),
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  //botao excluir conta
  void _buttonExcluirContaDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 250.0, 
            width: 300.0,  
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center, 
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Deseja excluir a conta?',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Expanded(child: Container()),
                Column(
                  children: [
                    buildCancelarButton(
                      context: context,
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaPerfil()));
                      },
                    ),

                    SizedBox(height: 15.0),
                    
                    buildConfirmarButton(
                      context: context,
                      onPressed: () {
                        // 
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.black, width: 2.0),
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: -51.8,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          //parte azul da tela
          Container(
            width: double.infinity,
            height: 400.0,
            padding: EdgeInsets.only(top: 50.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 23, 39, 211),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                // imagem de Perfil
                Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/Personagem2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  '@celia',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  '153',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Pontuação Total',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 40.0),

          //botões de ação
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                _buildActionButton(
                  context,
                  text: 'Editar Conta',
                  icon: Icons.edit_outlined,
                  color: Color.fromRGBO(255, 247, 177, 1), 
                  textColor: Colors.black,
                  iconColor: Colors.black,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaEditarConta()));
                  },
                ),
                SizedBox(height: 25.0),
                _buildActionButton(
                  context,
                  text: 'Sair da Conta',
                  icon: Icons.logout,
                  color: Color.fromRGBO(252, 228, 236, 1), 
                  textColor: Colors.black,
                  iconColor: Colors.black,
                  onPressed: () {
                    _buttonSairContaDialog(); 
                  },
                ),
                SizedBox(height: 25.0),
                _buildActionButton(
                  context,
                  text: 'Excluir Conta',
                  icon: Icons.delete_outline,
                  color: Color.fromARGB(255, 246, 83, 34), 
                  textColor: Colors.black,
                  iconColor: Colors.black,
                  onPressed: () {
                    _buttonExcluirContaDialog();
                  },
                ),
              ],
            ),
          ),

          Expanded(child: SizedBox()), 
          menuBottomNavigationBar(context, 1), 
        ],
      ),
    );
  }

  //função auxiliar para construir os botões de ação
  Widget _buildActionButton(
    BuildContext context, {
    required String text,
    required IconData icon,
    required Color color,
    required Color textColor,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
          side: BorderSide(
            color: Colors.black,
            width: 2.0,
          )
        ),
        foregroundColor: textColor.withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          Icon(
            icon,
            color: iconColor,
            size: 24.0,
          ),
        ],
      ),
    );
  }
}

