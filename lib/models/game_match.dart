import 'package:jogo_das_equacoes/models/player.dart';

class GameMatch {
  final Player player;
  final int mathScore;
  int gameAttempts = 3;

  GameMatch({this.mathScore, this.player});

  void decreaseGameAttempts() {
    if (gameAttempts > 0) {
      this.gameAttempts--;
    }
  }
}
