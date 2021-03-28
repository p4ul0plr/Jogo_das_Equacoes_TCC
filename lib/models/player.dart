import 'package:jogo_das_equacoes/models/player_status.dart';

class Player {
  final String name;
  final String gender;
  final String email;
  final String password;
  final String grade;
  final String school;
  final PlayerStatus playerStatus;

  Player({
    this.name,
    this.gender,
    this.email,
    this.password,
    this.grade,
    this.school,
    this.playerStatus,
  });

  @override
  String toString() {
    return 'Player{'
        'Nome: $name'
        ', Sexo: $gender'
        ', E-mail: $email'
        ', Senha: $password'
        ', Série: $grade'
        ', Escola: $school'
        ', Status do Jogador: $playerStatus'
        '}';
  }
}
