import 'package:jogo_das_equacoes/models/player.dart';

class GameMath {
  final Player player;
  final int mathScore;
  int gameAttempts = 3;

  GameMath({this.mathScore, this.player});

  void decreaseGameAttempts() {
    if (gameAttempts > 0) {
      this.gameAttempts--;
    }
  }
}
