import 'package:jogo_das_equacoes/models/equations/equation_abstract.dart';

class EquationXmultiplicationPositiveNegative extends Equation {
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
      do {
        _firstNumber = random.negativePositiveNumber(max: 10);
      } while (_firstNumber == 1 || _firstNumber == -1);
      _secondNumber = random.negativePositiveNumber(max: 10);
      _thirdNumber = random.negativePositiveNumber(max: 10);
      _itIsNotDivisible =
          (_thirdNumber + (-1 * _secondNumber)) % _firstNumber != 0;
      _notNullNumerator = _secondNumber == _thirdNumber;
    } while (_itIsNotDivisible || _notNullNumerator);
    _equation1.add(
      random.mathematicalSign(
        number: _firstNumber,
        signalPositive: false,
      ),
    );
    _equation1.add(_firstNumber.abs().toString());
    _equation1.add('·');
    _equation1.add('x');
    _equation1.add(
      random.mathematicalSign(
        number: _secondNumber,
        signalPositive: true,
      ),
    );
    _equation1.add(_secondNumber.abs().toString());
    _equation1.add('=');
    _equation1.add(
      random.mathematicalSign(
        number: _thirdNumber,
        signalPositive: false,
      ),
    );
    _equation1.add(_thirdNumber.abs().toString());
    _equation1.removeWhere((element) => element == '');
    equation.add(_equation1);
    equation.add(_equation2);
    return equation;
  }

  @override
  int getResultOfTheEquation() {
    return (_thirdNumber + (_secondNumber * -1)) ~/ _firstNumber;
  }
}
