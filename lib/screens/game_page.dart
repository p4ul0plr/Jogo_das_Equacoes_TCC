import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_timer.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/models/game_match.dart';

class GamePage extends StatefulWidget {
  final String quest;

  GamePage({this.quest});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameMath gameMath = new GameMath();

  @override
  Widget build(BuildContext context) {
    print('Teste');
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Missão: ${widget.quest}'),
        //title: Text('Missão: ${widget.quest}'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _getNumberOfHearts(),
            ),
          ),
          CustomTimer(
            counter: 300,
            // ignore: missing_return
            timerStop: (timerStop) {
              if (timerStop) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              child: Text('Decrementar vidas'),
              onPressed: () {
                setState(() {
                  print(gameMath.gameAttempts);
                  gameMath.decreaseGameAttempts();
                });
              },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _getNumberOfHearts() {
    List<Widget> listOfHearts = List();
    int numberOfHearts = gameMath.gameAttempts;
    switch (numberOfHearts) {
      case 3:
        listOfHearts.add(IconHeart());
        listOfHearts.add(IconHeart());
        listOfHearts.add(IconHeart());
        break;
      case 2:
        listOfHearts.add(IconHeart());
        listOfHearts.add(IconHeart());
        listOfHearts.add(IconsHeartBorder());
        break;
      case 1:
        listOfHearts.add(IconHeart());
        listOfHearts.add(IconsHeartBorder());
        listOfHearts.add(IconsHeartBorder());
        break;
      case 0:
        listOfHearts.add(IconsHeartBorder());
        listOfHearts.add(IconsHeartBorder());
        listOfHearts.add(IconsHeartBorder());
        break;
    }
    return listOfHearts;
  }
}

class IconsHeartBorder extends StatelessWidget {
  const IconsHeartBorder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_border,
      size: 32.0,
    );
  }
}

class IconHeart extends StatelessWidget {
  const IconHeart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite,
      size: 32.0,
    );
  }
}
