import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_timer.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    print('Teste');
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Missão 1'),
        actions: <Widget>[
          CustomTimer(
            counter: 10,
            // ignore: missing_return
            timerStop: (timerStop) {
              if (timerStop) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
