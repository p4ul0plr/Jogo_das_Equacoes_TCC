import 'package:jogo_das_equacoes/models/equarions/equation.dart';

class EquationXpositive extends Equation {
  int _firstNumber;
  int _secondNumber;

  EquationXpositive() {
    _firstNumber = generatePositiveRandomNumber(max: 10);
    _secondNumber = generatePositiveRandomNumber(max: 10);
  }

  @override
  List getEquation() {
    equation.add('x');
    equation.add('+');
    equation.add(_firstNumber.toString());
    equation.add('=');
    equation.add(_secondNumber.toString());
    return equation;
  }

  @override
  int getResultOfTheEquation() {
    resultOfTheEquation = _secondNumber - _firstNumber;
    return resultOfTheEquation;
  }
}
