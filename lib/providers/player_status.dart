import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerStatusProvider extends ChangeNotifier {
  int _score;
  int _quest;
  int _stage;

  PlayerStatusProvider() {
    this._score = 0;
    this._quest = 1;
    this._stage = 1;
    _initialState();
  }

  void _initialState() {
    _syncDataWithProvider();
  }

  void incrementScore(int score) {
    _score += score;
    _updateSharedPrefrencesScore();
    notifyListeners();
  }

  void incrementQuest() {
    if (_quest < 10 * _stage) {
      _quest++;
      _updateSharedPrefrencesQuest();
      notifyListeners();
    } else if (_stage < 4) {
      _quest++;
      _stage++;
      _updateSharedPrefrencesQuest();
      _updateSharedPrefrencesStage();
      notifyListeners();
    }
  }

  int getScore() {
    return _score;
  }

  int getQuest() {
    return _quest;
  }

  int getStage() {
    return _stage;
  }

  Future _updateSharedPrefrencesScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', _score);
  }

  Future _updateSharedPrefrencesQuest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quest', _quest);
  }

  Future _updateSharedPrefrencesStage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('stage', _stage);
  }

  void _syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var reslutScore = prefs.getInt('score');
    if (reslutScore != null) {
      _score = reslutScore;
    }
    var reslutQuest = prefs.getInt('quest');
    if (reslutScore != null) {
      _quest = reslutQuest;
    }
    var reslutStage = prefs.getInt('stage');
    if (reslutScore != null) {
      _stage = reslutStage;
    }
    notifyListeners();
  }
}
