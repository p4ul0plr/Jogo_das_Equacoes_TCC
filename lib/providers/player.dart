import 'package:flutter/cupertino.dart';
import 'package:jogo_das_equacoes/models/player.dart';

class PlayerProvider extends ChangeNotifier {
  Player player;

  void signIn(Player newPlayer) {
    player = newPlayer;
    notifyListeners();
  }

  void signOut() {
    this.player = null;
    notifyListeners();
  }
}
