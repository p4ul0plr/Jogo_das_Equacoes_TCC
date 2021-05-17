import 'package:jogo_das_equacoes/models/consts.dart';

class PlayerStatus {
  int score;
  int stage;
  int quest;

  PlayerStatus({this.score = 0, this.stage = 1, this.quest = 1});

  PlayerStatus.fromJson(Map<String, dynamic> json)
      : score = json['score'],
        stage = json['stage'],
        quest = json['quest'];

  Map<String, dynamic> toJson() => {
        'score': score,
        'stage': stage,
        'quest': quest,
      };

  void incrementScore(int score) {
    if (this.score != null) {
      this.score += score;
    }
  }

  void incrementQuest() {
    if (this.quest < NUMBER_OF_QUESTS_IN_EACH_STAGE * this.stage) {
      this.quest++;
    } else if (this.stage < NUMBER_OF_STAGES) {
      this.quest++;
      this.stage++;
    }
  }

  void decreaseQuest() {
    bool _lastQuestOfStage = (quest % NUMBER_OF_QUESTS_IN_EACH_STAGE == 0);
    if (_lastQuestOfStage) {
      this.quest--;
      this.stage--;
    } else {
      this.quest--;
    }
  }

  void resetScore() {
    if (this.score != null) {
      this.score = 0;
    }
  }

  /* increaseStage() {
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
    notifyListeners();
  } 

  @override
  String toString() {
    return 'PlayerStatus{Fase: $stage, Missão: $quest, Pontuação: $score}';
  }*/
}
