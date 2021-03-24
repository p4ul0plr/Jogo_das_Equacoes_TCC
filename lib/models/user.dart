class User {
  final String name;
  final String gender;
  final String email;
  final String password;
  final String grade;
  final String school;
  final int score;

  User({
    this.name,
    this.gender,
    this.email,
    this.password,
    this.grade,
    this.school,
    this.score = 0,
  });

  @override
  String toString() {
    // TODO: implement toString
    return 'User{'
        'Nome: $name'
        ', Sexo: $gender'
        ', E-mail: $email'
        ', Senha: $password'
        ', Série: $grade'
        ', Escola: $school'
        ', Pontuação: $score'
        '}';
  }
}
