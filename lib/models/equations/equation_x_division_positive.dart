import 'package:jogo_das_equacoes/models/equations/equation_abstract.dart';

class EquationXdivisionPositive extends Equation {
  int _firstNumber;
  int _secondNumber;
  int _thirdNumber;

  @override
  List getEquations() {
    List _equation1 = [];
    List _equation2 = ['x', '=', '?'];
    bool _notNullNumerator;
    do {
      _firstNumber = 1 + random.positiveNumber(max: 4);
      _secondNumber = random.positiveNumber(max: 5);
      _thirdNumber = random.positiveNumber(max: 5);
      _notNullNumerator = _secondNumber == _thirdNumber;
    } while (_notNullNumerator);
    _equation1.add('x');
    _equation1.add('/');
    _equation1.add(_firstNumber.toString());
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
    return _firstNumber * (_thirdNumber - _secondNumber);
  }
}
