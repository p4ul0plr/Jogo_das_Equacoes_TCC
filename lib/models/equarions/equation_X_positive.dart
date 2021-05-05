import 'package:jogo_das_equacoes/models/equarions/equation.dart';

class EquationXpositive extends Equation {
  String _firstNumber;
  String _secondNumber;

  EquationXpositive() {
    _firstNumber = generatePositiveRandomNumber(max: 10);
    _secondNumber = generatePositiveRandomNumber(max: 10);
  }

  @override
  List<String> getEquation() {
    equation.add('x');
    equation.add('+');
    equation.add(_firstNumber);
    equation.add('=');
    equation.add(_secondNumber);
    return equation;
  }

  @override
  int getResultOfTheEquation() {
    resultOfTheEquation = int.parse(_secondNumber) - int.parse(_firstNumber);
    return resultOfTheEquation;
  }
}
