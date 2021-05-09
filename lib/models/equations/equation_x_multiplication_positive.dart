import 'package:jogo_das_equacoes/models/equations/equation_abstract.dart';

class EquationXmultiplicationPositive extends Equation {
  int _firstNumber;
  int _secondNumber;
  int _thirdNumber;

  @override
  List getEquations() {
    List _equation1 = [];
    List _equation2 = ['x', '=', '?'];
    bool _itIsNotDivisible;
    bool _notNullNumerator;
    do {
      _firstNumber = 1 + generatePositiveRandomNumber(max: 9);
      _secondNumber = generatePositiveRandomNumber(max: 10);
      _thirdNumber = generatePositiveRandomNumber(max: 10);
      _itIsNotDivisible = (_thirdNumber - _secondNumber) % _firstNumber != 0;
      _notNullNumerator = _secondNumber == _thirdNumber;
    } while (_itIsNotDivisible || _notNullNumerator);
    _equation1.add(_firstNumber.toString());
    _equation1.add('*');
    _equation1.add('x');
    _equation1.add('+');
    _equation1.add(_secondNumber.toString());
    _equation1.add('=');
    _equation1.add(_thirdNumber.toString());
    equation.add(_equation1);
    equation.add(_equation2);
    return equation;
  }

  @override
  int getResultOfTheEquation() {
    return (_thirdNumber - _secondNumber) ~/ _firstNumber;
  }
}
