import 'package:jogo_das_equacoes/models/equations/equation_abstract.dart';

class EquationXpositiveNegative extends Equation {
  int _firstNumber;
  int _secondNumber;

  EquationXpositiveNegative() {
    _firstNumber = random.negativePositiveNumber(max: 10);
    _secondNumber = random.negativePositiveNumber(max: 10);
  }

  @override
  List getEquations() {
    List _equation1 = [];
    List _equation2 = ['x', '=', '?'];
    _equation1.add('x');
    _equation1.add(random.mathematicalSign(
      number: _firstNumber,
      signalPositive: true,
    ));
    _equation1.add(_firstNumber.abs().toString());
    _equation1.add('=');
    _equation1.add(random.mathematicalSign(
      number: _secondNumber,
      signalPositive: false,
    ));
    _equation1.add(_secondNumber.abs().toString());
    _equation1.remove('');
    equation.add(_equation1);
    equation.add(_equation2);
    return equation;
  }

  @override
  int getResultOfTheEquation() {
    resultOfTheEquation = (-1 * _firstNumber) + _secondNumber;
    return resultOfTheEquation;
  }
}
