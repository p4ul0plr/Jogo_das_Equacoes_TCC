import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/models/player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameMatchProvider extends ChangeNotifier {
  /* Player _player;
  int _mathScore; */
  int _gameAttempts;

  GameMatchProvider() {
    this._gameAttempts = 3;
    _updateSharedPrefrencesGameAttempts();
    _initialState();
  }

  void newGameMath() {
    this._gameAttempts = 3;
    _updateSharedPrefrencesGameAttempts();
  }

  int getGameAttempts() {
    return this._gameAttempts;
  }

  void _initialState() async {
    _syncDataWithProvider();
  }

  void decreaseGameAttempts() {
    if (this._gameAttempts > 0) {
      this._gameAttempts--;
      _updateSharedPrefrencesGameAttempts();
      notifyListeners();
    }
  }

  Future _updateSharedPrefrencesGameAttempts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('game_attempts', this._gameAttempts);
  }

  void _syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var reslut = prefs.getInt('game_attempts') ?? 0;
    if (reslut != null) {
      this._gameAttempts = reslut;
    }
    notifyListeners();
  }
}
