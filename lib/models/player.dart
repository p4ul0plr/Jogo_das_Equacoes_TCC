import 'package:jogo_das_equacoes/models/player_status.dart';

class Player {
  final String id;
  final String name;
  final String gender;
  final String email;
  final String password;
  final String grade;
  final String school;
  final PlayerStatus playerStatus;

  Player({
    this.id,
    this.name,
    this.gender,
    this.email,
    this.password,
    this.grade,
    this.school,
    this.playerStatus,
  });

  Player.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        gender = json['gender'],
        email = json['email'],
        password = json['password'],
        grade = json['grade'],
        school = json['school'],
        playerStatus = PlayerStatus.fromJson(json['playerStatus']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'gender': gender,
        'email': email,
        'password': password,
        'grade': grade,
        'school': school,
        'playerStatus': playerStatus.toJson(),
      };

  @override
  String toString() {
    return 'Player{'
        'Id: $id'
        ', Nome: $name'
        ', Sexo: $gender'
        ', E-mail: $email'
        ', Senha: $password'
        ', Série: $grade'
        ', Escola: $school'
        ', Status do Jogador: $playerStatus'
        '}';
  }
}
