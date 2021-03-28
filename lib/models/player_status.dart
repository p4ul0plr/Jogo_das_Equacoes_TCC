class PlayerStatus {
  final int score;
  final int stage;
  final int quest;

  PlayerStatus({this.score = 0, this.stage = 1, this.quest = 1});

  @override
  String toString() {
    return 'PlayerStatus{Fase: $stage, Missão: $quest, Pontuação: $score}';
  }
}
