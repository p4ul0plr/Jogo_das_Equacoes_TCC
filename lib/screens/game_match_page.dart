import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/match_result_alert_dialog.dart';
import 'package:jogo_das_equacoes/components/custom_boxshadow.dart';
import 'package:jogo_das_equacoes/components/custom_timer.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/components/equation_widget.dart';
import 'package:jogo_das_equacoes/database/authentication_service.dart';
import 'package:jogo_das_equacoes/database/dao/player_dao.dart';
import 'package:jogo_das_equacoes/models/colors.dart';
import 'package:jogo_das_equacoes/models/consts.dart';
import 'package:jogo_das_equacoes/models/equations/equation_abstract.dart';
import 'package:jogo_das_equacoes/models/equations/equation_x_division_negative.dart';
import 'package:jogo_das_equacoes/models/equations/equation_x_division_positive.dart';
import 'package:jogo_das_equacoes/models/equations/equation_x_division_positive_negative.dart';
import 'package:jogo_das_equacoes/models/equations/equation_x_multiplication_negative.dart';
import 'package:jogo_das_equacoes/models/equations/equation_x_multiplication_positive.dart';
import 'package:jogo_das_equacoes/models/equations/equation_x_multiplication_positive_negative.dart';
import 'package:jogo_das_equacoes/models/equations/equation_x_negative.dart';
import 'package:jogo_das_equacoes/models/equations/equation_x_positive.dart';
import 'package:jogo_das_equacoes/models/equations/equation_x_positive_negative.dart';
import 'package:jogo_das_equacoes/models/equations/equation_xy_negative.dart';
import 'package:jogo_das_equacoes/models/equations/equation_xy_positive.dart';
import 'package:jogo_das_equacoes/models/equations/equation_xy_positive_negative.dart';
import 'package:jogo_das_equacoes/models/randon_numbers.dart';
import 'package:jogo_das_equacoes/models/sounds.dart';
import 'package:jogo_das_equacoes/providers/game_match.dart';
import 'package:jogo_das_equacoes/providers/player.dart';
import 'package:jogo_das_equacoes/providers/player_status_shared.dart';
import 'package:provider/provider.dart';

const int NUMBER_OF_ALTERNATIVES = 4;
const int MAXIMUM_NUMBER_OF_THE_COUNTER = 60;
const int WEIGHT_OF_TIME = 10;

int _currentTime;
int _currentQuest;
int _currentStage;

// ignore: must_be_immutable
class GameMatchPage extends StatefulWidget {
  final String quest;
  final int currentStage;
  Equation _equationInstance;
  List _equation;
  int _result;

  GameMatchPage({this.quest, this.currentStage}) {
    _equationInstance = _getEquationInstance(quest);
    _equation = _equationInstance.getEquations();
    _result = _equationInstance.getResultOfTheEquation();
    _currentQuest = int.parse(quest);
    _currentStage = this.currentStage;
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
        centerTitle: true,
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
            child: _showMainGameScreen(context, widget._equation),
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
      margin: EdgeInsets.only(
        right: 16.0,
        bottom: 16.0,
        left: 8.0,
        top: 16.0,
      ),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).accentColor,
        boxShadow: [CustomBoxShadow()],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Alternativas',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Schoolbell',
                  ),
                ),
              ),
            ] +
            _getAlternatives(widget._result, widget.quest),
      ),
    );
  }

  Container _showMainGameScreen(BuildContext context, List equation) {
    return Container(
      margin: EdgeInsets.only(
        left: 16.0,
        bottom: 16.0,
        right: 8.0,
        top: 16.0,
      ),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).accentColor,
        boxShadow: [CustomBoxShadow()],
      ),
      child: EquationWidget(equations: equation),
      /* child: Center(
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
        ),
      ), */
    );
  }

  void _timeIsOver(BuildContext context) {
    Navigator.of(context).pop();
    Sounds().failureSound();
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return MatchResultAlertDialog(
          quest: _currentQuest,
          currentStage: _currentStage,
        );
      },
    );
  }

  List<Widget> _getAlternatives(int result, String quest) {
    RandomNumbers _random = RandomNumbers();
    int _randomNumber;
    int _max = 20;
    List<int> _alternatives = [];
    List<Widget> _alternativeButtons = [];
    _alternatives.add(result);
    for (var i = 0; i < NUMBER_OF_ALTERNATIVES - 1; i++) {
      do {
        _randomNumber = _random.negativePositiveNumber(max: _max);
      } while (_alternatives.any((element) => element == _randomNumber));
      _alternatives.add(_randomNumber);
    }
    _alternatives.shuffle();
    for (var i = 0; i < NUMBER_OF_ALTERNATIVES; i++) {
      _alternativeButtons.add(
        AlternativeButton(
          alternative: _alternatives[i],
          result: result,
          currentQuest: int.parse(quest),
        ),
      );
    }
    return _alternativeButtons;
  }
}

int _calculateTheScore(BuildContext context) {
  GameMatchProvider _gamematchProvider =
      Provider.of<GameMatchProvider>(context, listen: false);
  PlayerStatusProviderShared _playerStatusProvider =
      Provider.of<PlayerStatusProviderShared>(context, listen: false);
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
  _incrementScore(context, _calculatedScore, _playerStatusProvider);
  return _calculatedScore;
}

void _incrementScore(
  BuildContext context,
  int _calculatedScore,
  PlayerStatusProviderShared _playerStatusProvider,
) {
  var player = Provider.of<PlayerProvider>(context, listen: false).player;
  if (player != null) {
    player.playerStatus.incrementScore(_calculatedScore);
    PlayerDao().update({
      'playerStatus.score': player.playerStatus.score,
    }, player.id);
  } else {
    _playerStatusProvider.incrementScore(_calculatedScore);
  }
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
  } else if (_quest > 10 && _quest <= 13) {
    //11 ... 15 = (ex: 2*x+4=6)
    _equationInstance = EquationXmultiplicationPositive();
  } else if (_quest > 13 && _quest <= 16) {
    //16 ... 20 = (ex: 2*x-4=6)
    _equationInstance = EquationXmultiplicationNegative();
  } else if (_quest > 16 && _quest <= 20) {
    //16 ... 20 = (ex: 2*x+4=-6)
    _equationInstance = EquationXmultiplicationPositiveNegative();
  } else if (_quest > 20 && _quest <= 23) {
    //21 ... 23 = (ex: x/2+4=6)
    _equationInstance = EquationXdivisionPositive();
  } else if (_quest > 23 && _quest <= 26) {
    //24 ... 26 = (ex: x/2-4=6)
    _equationInstance = EquationXdivisionNegative();
  } else if (_quest > 26 && _quest <= 30) {
    //27 ... 30 = (ex: x/2+4=-6)
    _equationInstance = EquationXdivisionPositiveNegative();
  } else if (_quest > 30 && _quest <= 33) {
    //31 ... 33 = (ex: y=10;x+y=2)
    _equationInstance = EquationXYpositive();
  } else if (_quest > 33 && _quest <= 36) {
    //34 ... 36 = (ex: y=10;x-y=2)
    _equationInstance = EquationXYnegative();
  } else if (_quest > 36 && _quest <= 40) {
    //37 ... 40 = (ex: y=-10;x-y=-2)
    _equationInstance = EquationXYpositiveNegative();
  }
  return _equationInstance;
}

class AlternativeButton extends StatelessWidget {
  final int alternative;
  final int result;
  final int currentQuest;

  AlternativeButton({
    @required this.alternative,
    @required this.result,
    @required this.currentQuest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: ThemeColors().blue, // background
          onPrimary: Colors.white, // foreground
        ),
        child: Text(
          alternative.toString(),
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          _rightOrWrong(context);
        },
      ),
    );
  }

  void _rightOrWrong(BuildContext context) {
    var player = Provider.of<PlayerProvider>(context, listen: false).player;
    if (player != null) {
      var _playerProvider = Provider.of<PlayerProvider>(context, listen: false);
      int _quest = _playerProvider.player.playerStatus.quest;
      if (alternative != result) {
        _wrongAlternative(context);
      } else {
        if (_quest == currentQuest) {
          bool _lastQuest =
              currentQuest == NUMBER_OF_STAGES * NUMBER_OF_QUESTS_IN_EACH_STAGE;
          if (_lastQuest) {
            //_finishedTheGame(context);
            _rightAlternativeAndIncrementQuestLoggedIn(
              _playerProvider,
              context,
            );
          } else {
            _rightAlternativeAndIncrementQuestLoggedIn(
              _playerProvider,
              context,
            );
          }
        } else {
          _rightAlternative(context);
        }
      }
    } else {
      var _playerStatusProvider =
          Provider.of<PlayerStatusProviderShared>(context, listen: false);
      int _quest = _playerStatusProvider.getQuest();
      if (alternative != result) {
        _wrongAlternative(context);
      } else {
        if (_quest == currentQuest) {
          bool _lastQuest =
              currentQuest == NUMBER_OF_STAGES * NUMBER_OF_QUESTS_IN_EACH_STAGE;
          if (_lastQuest) {
            //_finishedTheGame(context);
            _rightAlternativeAndIncrementQuestLoggedOut(
              _playerStatusProvider,
              context,
            );
          } else {
            _rightAlternativeAndIncrementQuestLoggedOut(
              _playerStatusProvider,
              context,
            );
          }
        } else {
          _rightAlternative(context);
        }
      }
    }
  }

  void _rightAlternativeAndIncrementQuestLoggedIn(
    PlayerProvider playerProvider,
    BuildContext context,
  ) async {
    User firebaseUser = context.read<AuthenticationService>().currentUser;
    if (firebaseUser != null) {
      PlayerDao().incrementQuest(firebaseUser.uid);
      var player = await PlayerDao().read(firebaseUser.uid);
      var playerProvider = Provider.of<PlayerProvider>(context, listen: false);
      playerProvider.signIn(player);
    }
    playerProvider.player.playerStatus.incrementQuest();
    _rightAlternative(context);
  }

  void _rightAlternativeAndIncrementQuestLoggedOut(
    PlayerStatusProviderShared playerStatusProvider,
    BuildContext context,
  ) {
    playerStatusProvider.incrementQuest();
    _rightAlternative(context);
  }

  void _finishedTheGame(BuildContext context) {
    Navigator.of(context).pop();
    int _score = _calculateTheScore(context);
    Sounds().successSound();
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return MatchResultAlertDialog(
          score: _score,
          quest: _currentQuest,
          currentStage: _currentStage,
        );
      },
    );
  }

  void _rightAlternative(BuildContext context) {
    Navigator.of(context).pop();
    int _score = _calculateTheScore(context);
    Sounds().successSound();
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return MatchResultAlertDialog(
          score: _score,
          quest: _currentQuest,
          currentStage: _currentStage,
        );
      },
    );
  }

  void _wrongAlternative(BuildContext context) {
    GameMatchProvider _gameMatchProvider =
        Provider.of<GameMatchProvider>(context, listen: false);
    _gameMatchProvider.decreaseGameAttempts();
    int _matchAttempts = _gameMatchProvider.getMatchAttempts();
    Sounds().failureSound();
    if (_matchAttempts == 0) {
      Navigator.of(context).pop();
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return MatchResultAlertDialog(
            quest: _currentQuest,
            currentStage: _currentStage,
          );
        },
      );
    }
  }
}

class Hearts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameMatchProvider>(builder: (context, gameMatch, child) {
      int numberOfHearts = gameMatch.getMatchAttempts();
      return Container(
        padding: EdgeInsets.only(right: 32.0),
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
    /* return Icon(
      Icons.favorite_border,
      size: 32.0,
      color: ThemeColors().pink,
    ); */
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Image.asset(
        'assets/images/broken-heart2.png',
        width: 32.0,
      ),
    );
  }
}

class IconHeart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* return Icon(
      Icons.favorite,
      size: 32.0,
      color: ThemeColors().pink,
    ); */
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Image.asset(
        'assets/images/heart.png',
        width: 32.0,
      ),
    );
  }
}
