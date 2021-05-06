import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_timer.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/models/equarions/equation.dart';
import 'package:jogo_das_equacoes/models/equarions/equation_X_negative.dart';
import 'package:jogo_das_equacoes/models/equarions/equation_X_positive.dart';
import 'package:jogo_das_equacoes/models/equarions/equation_X_positive_negative.dart';
import 'package:jogo_das_equacoes/providers/game_match.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  final String quest;

  GamePage({this.quest});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    Provider.of<GameMatchProvider>(context, listen: false).newGameMath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<GameMatchProvider>(context, listen: false)
        .getGameAttempts());
    Equation _equationInstance = getEquationInstance();
    List _equation = _equationInstance.getEquation();
    int _result = _equationInstance.getResultOfTheEquation();
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Missão: ${widget.quest}'),
        actions: <Widget>[
          Hearts(),
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
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).accentColor,
              ),
              child: Center(child: Text(_equation.toString())),
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
                  AlternativeButton(alternative: _result.toString()),
                  Spacer(),
                  ElevatedButton(
                    child: Text('Alternativa 2'),
                    onPressed: () {
                      Provider.of<GameMatchProvider>(context, listen: false)
                          .decreaseGameAttempts();
                      print(
                          Provider.of<GameMatchProvider>(context, listen: false)
                              .getGameAttempts());
                    },
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

  Equation getEquationInstance() {
    Equation _equationInstance;
    int _quest = int.parse(widget.quest);
    if (_quest <= 3) {
      //1 ... 3 = X+ (ex: x+3=5)
      _equationInstance = EquationXpositive();
    } else if (_quest > 3 && _quest <= 6) {
      //4 ... 6 = X- (ex: x-3=5)
      _equationInstance = EquationXnegative();
    } else if (_quest > 6 && _quest <= 10) {
      //7 ... 10 = X+- (ex: x+3=-5)
      _equationInstance = EquationXpositiveNegative();
    } else if (_quest > 10 && _quest <= 15) {
    } else if (_quest > 15 && _quest <= 20) {
    } else if (_quest > 20 && _quest <= 30) {}
    return _equationInstance;
  }
}

class AlternativeButton extends StatelessWidget {
  final String alternative;

  AlternativeButton({this.alternative});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(),
        child: Text(
          alternative,
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {},
      ),
    );
  }
}

class IconsHeartBorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_border,
      size: 32.0,
    );
  }
}

class IconHeart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite,
      size: 32.0,
    );
  }
}

class Hearts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameMatchProvider>(builder: (context, gameMatch, child) {
      int numberOfHearts = gameMatch.getGameAttempts();
      return Container(
        padding: EdgeInsets.only(right: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _getNumberOfHearts(context, numberOfHearts),
        ),
      );
    });
  }

  List<Widget> _getNumberOfHearts(BuildContext context, int numberOfHearts) {
    List<Widget> listOfHearts = [];
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
      default:
        return null;
    }
    return listOfHearts;
  }
}
