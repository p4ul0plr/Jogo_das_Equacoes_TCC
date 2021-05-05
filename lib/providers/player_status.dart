import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerStatusProvider extends ChangeNotifier {
  int _score;
  int _quest;
  int _stage;

  PlayerStatusProvider() {
    this._quest = 1;
    this._score = 0;
    this._stage = 1;
    _updateAllSharedPrefrences();
    _initialState();
  }

  void _initialState() {
    _syncDataWithProvider();
  }

  void incrementScore(int score) {
    this._score += score;
    _updateSharedPrefrencesScore();
    notifyListeners();
  }

  void incrementQuest() {
    if (this._quest < 10 * this._stage) {
      this._quest++;
      _updateSharedPrefrencesQuest();
      notifyListeners();
    } else if (this._stage < 4) {
      this._quest++;
      this._stage++;
      _updateSharedPrefrencesQuest();
      _updateSharedPrefrencesStage();
      notifyListeners();
    }
  }

  int getScore() {
    return this._score;
  }

  int getQuest() {
    return this._quest;
  }

  int getStage() {
    return this._stage;
  }

  void _updateAllSharedPrefrences() {
    _updateSharedPrefrencesScore();
    _updateSharedPrefrencesQuest();
    _updateSharedPrefrencesStage();
  }

  Future _updateSharedPrefrencesScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', this._score);
  }

  Future _updateSharedPrefrencesQuest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quest', this._quest);
  }

  Future _updateSharedPrefrencesStage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('stage', this._stage);
  }

  void _syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var reslutScore = prefs.getInt('score') ?? 0;
    if (reslutScore != null) {
      this._score = reslutScore;
    }
    var reslutQuest = prefs.getInt('quest') ?? 0;
    if (reslutQuest != null) {
      this._quest = reslutQuest;
    }
    var reslutStage = prefs.getInt('stage') ?? 0;
    if (reslutStage != null) {
      this._stage = reslutStage;
    }
    notifyListeners();
  }
}
