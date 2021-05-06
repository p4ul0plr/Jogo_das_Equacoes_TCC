import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_alert_dialog.dart';
import 'package:jogo_das_equacoes/components/custom_timer.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/models/equarions/equation.dart';
import 'package:jogo_das_equacoes/models/equarions/equation_X_negative.dart';
import 'package:jogo_das_equacoes/models/equarions/equation_X_positive.dart';
import 'package:jogo_das_equacoes/models/equarions/equation_X_positive_negative.dart';
import 'package:jogo_das_equacoes/models/player_status.dart';
import 'package:jogo_das_equacoes/providers/game_match.dart';
import 'package:jogo_das_equacoes/providers/player_status.dart';
import 'package:jogo_das_equacoes/screens/quests_page.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  final String quest;
  Equation _equationInstance;
  List _equation;
  int _result;
  int currentTime;

  GamePage({this.quest}) {
    _equationInstance = getEquationInstance(quest);
    _equation = _equationInstance.getEquation();
    _result = _equationInstance.getResultOfTheEquation();
  }

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
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Missão: ${widget.quest}'),
        actions: <Widget>[
          Hearts(),
          CustomTimer(
            counter: 3,
            currentTime: (int currentTime) {
              widget.currentTime = currentTime;
            },
            timerStop: (bool timerStop) {
              if (timerStop) {
                _timeIsOver(context);
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
              child: Center(
                  child: Text(
                widget._equation
                    .toString()
                    .replaceAll(',', ' ')
                    .replaceAll('[', '')
                    .replaceAll(']', ''),
                style: TextStyle(
                  fontSize: 80.0,
                  fontFamily: 'Schoolbell',
                ),
              )),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          'Alternativas',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'Schoolbell',
                          ),
                        ),
                      ),
                    ] +
                    getAlternatives(widget._result, widget.quest),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _timeIsOver(BuildContext context) {
    Navigator.of(context).pop();
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          score: 750,
        );
      },
    );
  }

  int negativePositiveRandomNumber({@required int max}) {
    bool sign = Random().nextBool();
    if (sign) {
      return 1 + Random().nextInt(max);
    }
    return -1 * (1 + Random().nextInt(max));
  }

  List<Widget> getAlternatives(int result, String quest) {
    int randomNumber;
    int max = 20;
    List<int> _alternatives = [];
    _alternatives.add(result);
    for (var i = 0; i < 3; i++) {
      do {
        randomNumber = negativePositiveRandomNumber(max: max);
      } while (_alternatives.any((element) => element == randomNumber));
      _alternatives.add(randomNumber);
    }
    _alternatives.shuffle();
    return [
      AlternativeButton(
        alternative: _alternatives[0],
        result: result,
        quest: int.parse(quest),
      ),
      AlternativeButton(
        alternative: _alternatives[1],
        result: result,
        quest: int.parse(quest),
      ),
      AlternativeButton(
        alternative: _alternatives[2],
        result: result,
        quest: int.parse(quest),
      ),
      AlternativeButton(
        alternative: _alternatives[3],
        result: result,
        quest: int.parse(quest),
      ),
    ];
  }
}

Equation getEquationInstance(String quest) {
  Equation _equationInstance;
  int _quest = int.parse(quest);
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

class AlternativeButton extends StatelessWidget {
  final int alternative;
  final int result;
  final int quest;

  AlternativeButton({
    @required this.alternative,
    @required this.result,
    @required this.quest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(),
        child: Text(
          alternative.toString(),
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          var playerStatusProvider =
              Provider.of<PlayerStatusProvider>(context, listen: false);
          var gameMatchProvider =
              Provider.of<GameMatchProvider>(context, listen: false);
          if (alternative != result) {
            Provider.of<GameMatchProvider>(context, listen: false)
                .decreaseGameAttempts();
          } else {
            if (playerStatusProvider.getQuest() == quest) {
              playerStatusProvider.incrementQuest();
              int stage = playerStatusProvider.getStage();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => QuestsPage(stage: stage),
                ),
              );
            } else {
              Navigator.of(context).pop();
            }
          }
          if (gameMatchProvider.getGameAttempts() == 0) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}

class IconHeartWithBorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_border,
      size: 32.0,
      color: Colors.red[200],
    );
  }
}

class IconHeart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite,
      size: 32.0,
      color: Colors.red[200],
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
        listOfHearts.add(IconHeartWithBorder());
        break;
      case 1:
        listOfHearts.add(IconHeart());
        listOfHearts.add(IconHeartWithBorder());
        listOfHearts.add(IconHeartWithBorder());
        break;
      case 0:
        listOfHearts.add(IconHeartWithBorder());
        listOfHearts.add(IconHeartWithBorder());
        listOfHearts.add(IconHeartWithBorder());
        break;
      default:
        return null;
    }
    return listOfHearts;
  }
}
