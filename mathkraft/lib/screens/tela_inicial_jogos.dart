import 'package:flutter/material.dart';
import 'package:mathkraft/screens/tela_jogo.dart';
import 'package:mathkraft/widgets/menu_navigation_bar_widget.dart';

class TelaInicialJogos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.white,
        elevation: 0,
          automaticallyImplyLeading: false
      ),
      //cabeçalho
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MathKraft',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10),
                Image.asset('lib/assets/MathKraft.png',
                  height: 100.0,
                ),
              ],
            ),

            SizedBox(height: 40.0),
            //pergunta aleatória
            Text(
              'Pergunta Aleatória',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 15.0),
            //botão verde jogar
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaJogo()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(224, 255, 255, 1),
                elevation: 0,
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                foregroundColor: Colors.teal,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(Icons.star, color: Colors.teal, size: 40.0, ),
                  SizedBox(width: 15.0),
                  Column(
                    children: [
                      Text(
                        'Jogar',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '7/? concluídos',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black, 
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 60.0),
            //quadrado amarelo da ofensiva
            Container(
              width: 400.0,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(249, 206, 79, 1),
                border: Border.all(color: Colors.black, width: 2.0),
                borderRadius:BorderRadius.circular(20.0),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded( 
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Sua ofensiva é de 8 perguntas',
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          
                          SizedBox(height: 30.0),
                          //botão jogar dentro do quadrado amarelo
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaJogo()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.all(15),
                              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Text('Jogar!',
                            style: TextStyle(color: Colors.white))
                            ,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    'lib/assets/Personagem1.png', 
                    height: 150.0,
                  ),
                ],
              ),
            ),
            //menu parte de baixo da tela
            Expanded(child: SizedBox()),
            menuBottomNavigationBar(context, 0),
          ],
        ),
      ),
    );
  }
}