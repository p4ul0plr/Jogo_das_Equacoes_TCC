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
          Expanded(
            flex: 12,
            child: Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).accentColor,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Alternativas',
                      style:
                          TextStyle(fontSize: 24.0, fontFamily: 'Schoolbell'),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(),
                    child: Text('Alternativa 1'),
                    onPressed: () {},
                  ),
                  Spacer(),
                  ElevatedButton(
                    child: Text('Alternativa 2'),
                    onPressed: () {},
                  ),
                  Spacer(),
                  ElevatedButton(
                    child: Text('Alternativa 3'),
                    onPressed: () {},
                  ),
                  Spacer(),
                  ElevatedButton(
                    child: Text('Alternativa 4'),
                    onPressed: () {},
                  ),
                  Spacer(),
                ],
              ),
            ),
          )
          /* Center(
            child: ElevatedButton(
              child: Text('Decrementar vidas'),
              onPressed: () {
                setState(() {
                  print(gameMath.gameAttempts);
                  gameMath.decreaseGameAttempts();
                });
              },
            ),
          ) */
        ],
      ),
    );
  }

  List<Widget> _getNumberOfHearts() {
    List<Widget> listOfHearts = [];
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
