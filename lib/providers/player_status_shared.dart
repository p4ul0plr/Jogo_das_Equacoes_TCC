import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/models/consts.dart';
import 'package:jogo_das_equacoes/models/player_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerStatusProviderShared extends ChangeNotifier {
  int _score;
  int _quest;
  int _stage;

  PlayerStatusProviderShared() {
    _initialState();
  }

  PlayerStatus getPlayerStatus() {
    return PlayerStatus(
      score: _score,
      quest: _quest,
      stage: _stage,
    );
  }

  void _initialState() {
    _syncDataWithProvider();
  }

  void incrementScore(int score) {
    if (this._score != null) {
      this._score += score;
      _updateSharedPrefrencesScore();
      notifyListeners();
    }
  }

  void incrementQuest() {
    if (this._quest < NUMBER_OF_QUESTS_IN_EACH_STAGE * this._stage) {
      this._quest++;
      _updateSharedPrefrencesQuest();
      notifyListeners();
    } else if (this._stage < NUMBER_OF_STAGES) {
      this._quest++;
      this._stage++;
      _updateSharedPrefrencesQuest();
      _updateSharedPrefrencesStage();
      notifyListeners();
    }
  }

  void decreaseQuest() {
    bool _lastQuestOfStage = (_quest % NUMBER_OF_QUESTS_IN_EACH_STAGE == 0);
    if (_lastQuestOfStage) {
      this._quest--;
      this._stage--;
      _updateSharedPrefrencesQuest();
      _updateSharedPrefrencesStage();
      notifyListeners();
    } else {
      this._quest--;
      _updateSharedPrefrencesQuest();
      notifyListeners();
    }
  }

  int getScore() {
    if (this._score == null) {
      this._score = 0;
    }
    return this._score;
  }

  int getQuest() {
    if (this._quest == null) {
      this._quest = 1;
    }
    return this._quest;
  }

  int getStage() {
    if (this._stage == null) {
      this._stage = 1;
    }
    return this._stage;
  }

  void resetScore() {
    if (this._score != null) {
      this._score = 0;
    }
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
    var reslutQuest = prefs.getInt('quest') ?? 1;
    if (reslutQuest != null) {
      this._quest = reslutQuest;
    }
    var reslutStage = prefs.getInt('stage') ?? 1;
    if (reslutStage != null) {
      this._stage = reslutStage;
    }
    notifyListeners();
  }

  PlayerStatusProviderShared.fromJson(Map<String, dynamic> json)
      : _score = json['score'],
        _stage = json['stage'],
        _quest = json['quest'];

  Map<String, dynamic> toJson() => {
        'score': _score,
        'stage': _stage,
        'quest': _quest,
      };
}
