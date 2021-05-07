import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameMatchProvider extends ChangeNotifier {
  /* Player _player;*/
  int _mathScore = 0;
  int _matchAttempts;

  GameMatchProvider() {
    this._matchAttempts = 3;
    _updateSharedPrefrencesGameAttempts();
    _initialState();
  }

  void newGameMath() {
    this._matchAttempts = 3;
    _updateSharedPrefrencesGameAttempts();
  }

  int getMatchAttempts() => this._matchAttempts;

  int getMathScore() => this._mathScore;

  void _initialState() async => _syncDataWithProvider();

  void decreaseGameAttempts() {
    if (this._matchAttempts > 0) {
      this._matchAttempts--;
      _updateSharedPrefrencesGameAttempts();
      notifyListeners();
    }
  }

  void incrementMathScote(int score) {
    if (this._mathScore != null) {
      this._mathScore += score;
      notifyListeners();
    }
  }

  Future _updateSharedPrefrencesGameAttempts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('game_attempts', this._matchAttempts);
  }

  void _syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var reslut = prefs.getInt('game_attempts') ?? 0;
    if (reslut != null) {
      this._matchAttempts = reslut;
    }
    notifyListeners();
  }
}
