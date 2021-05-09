import 'package:jogo_das_equacoes/models/equations/equation_abstract.dart';

class EquationXnegative extends Equation {
  int _firstNumber;
  int _secondNumber;

  EquationXnegative() {
    _firstNumber = generatePositiveRandomNumber(max: 10);
    _secondNumber = generatePositiveRandomNumber(max: 10);
  }

  @override
  List getEquations() {
    List _equation1 = [];
    List _equation2 = ['x', '=', '?'];
    _equation1.add('x');
    _equation1.add('-');
    _equation1.add(_firstNumber.toString());
    _equation1.add('=');
    _equation1.add(_secondNumber.toString());
    equation.add(_equation1);
    equation.add(_equation2);
    return equation;
  }

  @override
  int getResultOfTheEquation() {
    resultOfTheEquation = _firstNumber + _secondNumber;
    return resultOfTheEquation;
  }
}
