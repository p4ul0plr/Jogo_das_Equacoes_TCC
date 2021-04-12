import 'package:flutter/material.dart';

class PlayerStatus extends ChangeNotifier {
  int score;
  int stage;
  int quest;

  PlayerStatus({this.score = 0, this.stage = 1, this.quest = 1});

  increaseStage() {
    if (this.stage < 4) {
      this.stage++;
      notifyListeners();
    }
  }

  increaseQuest() {
    if (this.quest < 10 * this.stage) {
      this.quest++;
    } else if (this.stage < 4) {
      this.quest++;
      this.stage++;
    }
    print('Quest: ${this.quest}, Stage: ${this.stage}');
    notifyListeners();
  }

  @override
  String toString() {
    return 'PlayerStatus{Fase: $stage, Missão: $quest, Pontuação: $score}';
  }
}
