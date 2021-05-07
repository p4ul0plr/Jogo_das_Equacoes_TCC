import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_alert_dialog.dart';
import 'package:jogo_das_equacoes/components/custom_timer.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/models/consts.dart';
import 'package:jogo_das_equacoes/models/equarions/equation.dart';
import 'package:jogo_das_equacoes/models/equarions/equation_X_negative.dart';
import 'package:jogo_das_equacoes/models/equarions/equation_X_positive.dart';
import 'package:jogo_das_equacoes/models/equarions/equation_X_positive_negative.dart';
import 'package:jogo_das_equacoes/providers/game_match.dart';
import 'package:jogo_das_equacoes/providers/player_status.dart';
import 'package:provider/provider.dart';

const int NUMBER_OF_ALTERNATIVES = 4;
const int MAXIMUM_NUMBER_OF_THE_COUNTER = 60;
const int WEIGHT_OF_TIME = 10;

int _currentTime;
int _currentQuest;

// ignore: must_be_immutable
class GameMatchPage extends StatefulWidget {
  final String quest;
  Equation _equationInstance;
  List _equation;
  int _result;

  GameMatchPage({this.quest}) {
    _equationInstance = _getEquationInstance(quest);
    _equation = _equationInstance.getEquation();
    _result = _equationInstance.getResultOfTheEquation();
    _currentQuest = int.parse(quest);
  }

  @override
  _GameMatchPageState createState() => _GameMatchPageState();
}

class _GameMatchPageState extends State<GameMatchPage> {
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
            counter: MAXIMUM_NUMBER_OF_THE_COUNTER,
            currentTime: (int currentTime) {
              _currentTime = currentTime;
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
            child: _showMainGameScreen(context),
          ),
          Expanded(
            flex: 4,
            child: _showSecondaryGameScreen(context),
          )
        ],
      ),
    );
  }

  Container _showSecondaryGameScreen(BuildContext context) {
    return Container(
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
            _getAlternatives(widget._result, widget.quest),
      ),
    );
  }

  Container _showMainGameScreen(BuildContext context) {
    return Container(
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
    );
  }

  void _timeIsOver(BuildContext context) {
    Navigator.of(context).pop();
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CustomAlertDialog(quest: _currentQuest);
      },
    );
  }

  int _negativePositiveRandomNumber({@required int max}) {
    bool sign = Random().nextBool();
    if (sign) {
      return 1 + Random().nextInt(max);
    }
    return -1 * (1 + Random().nextInt(max));
  }

  List<Widget> _getAlternatives(int result, String quest) {
    int _randomNumber;
    int _max = 20;
    List<int> _alternatives = [];
    List<Widget> _alternativeButtons = [];
    _alternatives.add(result);
    for (var i = 0; i < NUMBER_OF_ALTERNATIVES - 1; i++) {
      do {
        _randomNumber = _negativePositiveRandomNumber(max: _max);
      } while (_alternatives.any((element) => element == _randomNumber));
      _alternatives.add(_randomNumber);
    }
    _alternatives.shuffle();
    for (var i = 0; i < NUMBER_OF_ALTERNATIVES; i++) {
      _alternativeButtons.add(
        AlternativeButton(
          alternative: _alternatives[i],
          result: result,
          quest: int.parse(quest),
        ),
      );
    }
    return _alternativeButtons;
  }
}

int _calculateTheScore(BuildContext context) {
  var _gamematchProvider =
      Provider.of<GameMatchProvider>(context, listen: false);
  int _gameAttempt = _gamematchProvider.getMatchAttempts();
  int _calculatedScore;
  int _weightingTime =
      ((MAXIMUM_NUMBER_OF_THE_COUNTER - _currentTime) * WEIGHT_OF_TIME);
  switch (_gameAttempt) {
    case 3:
      _calculatedScore = MAX_SCORE - _weightingTime;
      break;
    case 2:
      _calculatedScore = (MAX_SCORE * 3 ~/ 4) - _weightingTime;
      break;
    case 1:
      _calculatedScore = (MAX_SCORE * 2 ~/ 4) - _weightingTime;
      break;
    case 0:
      _calculatedScore = 0;
      break;
  }
  return _calculatedScore;
}

Equation _getEquationInstance(String quest) {
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
          var _playerStatusProvider =
              Provider.of<PlayerStatusProvider>(context, listen: false);
          int _quest = _playerStatusProvider.getQuest();
          var _gameMatchProvider =
              Provider.of<GameMatchProvider>(context, listen: false);
          if (alternative != result) {
            _wrongAlternative(context);
            int _matchAttempts = _gameMatchProvider.getMatchAttempts();
            if (_matchAttempts <= 0) {
              //Número de tentativas esgotados
              print('Número de tentativas esgotado');
              Navigator.of(context).pop();
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return CustomAlertDialog(quest: _currentQuest);
                },
              );
            }
          } else {
            if (_quest == quest) {
              //Alternativa correta e incrementar a missão
              _playerStatusProvider.incrementQuest();
              _rightAlternative(context);
            } else {
              //Alternativa correta sem  incrementar a missão
              _rightAlternative(context);
            }
          }
        },
      ),
    );
  }

  void _rightAlternative(BuildContext context) {
    Navigator.of(context).pop();
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
            score: _calculateTheScore(context), quest: _currentQuest);
      },
    );
  }

  void _wrongAlternative(BuildContext context) {
    Provider.of<GameMatchProvider>(context, listen: false)
        .decreaseGameAttempts();
  }
}

class Hearts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameMatchProvider>(builder: (context, gameMatch, child) {
      int numberOfHearts = gameMatch.getMatchAttempts();
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
