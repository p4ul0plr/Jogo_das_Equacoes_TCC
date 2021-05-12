import 'package:jogo_das_equacoes/models/equations/equation_abstract.dart';

class EquationXYpositiveNegative extends Equation {
  int _firstNumber;
  int _secondNumber;
  int _xSign;
  int _ySign;

  EquationXYpositiveNegative() {
    _firstNumber = random.negativePositiveNumber(max: 10);
    _secondNumber = random.negativePositiveNumber(max: 10);
    _xSign = random.negativePositiveNumber(max: 1);
    _ySign = random.negativePositiveNumber(max: 1);
  }

  @override
  List getEquations() {
    List _equation = [];
    _equation.add(_getEquation1());
    _equation.add(_getEquation2());
    _equation.add(_getEquation3());
    return _equation;
  }

  @override
  int getResultOfTheEquation() {
    return ((_firstNumber * _ySign) * (-1) + _secondNumber) * _xSign;
  }

  List _getEquation1() {
    List _equation = [];
    _equation.add('y');
    _equation.add('=');
    _equation.add(
      random.mathematicalSign(
        number: _firstNumber,
        signalPositive: false,
      ),
    );
    _equation.add(_firstNumber.abs().toString());
    _equation.removeWhere((element) => element == '');
    return _equation;
  }

  List _getEquation2() {
    List _equation = [];
    _equation.add(
      random.mathematicalSign(
        number: _xSign,
        signalPositive: false,
      ),
    );
    _equation.add('x');
    _equation.add(
      random.mathematicalSign(
        number: _ySign,
        signalPositive: true,
      ),
    );
    _equation.add('y');
    _equation.add('=');
    _equation.add(
      random.mathematicalSign(
        number: _secondNumber,
        signalPositive: false,
      ),
    );
    _equation.add(_secondNumber.abs().toString());
    _equation.removeWhere((element) => element == '');
    return _equation;
  }

  List _getEquation3() {
    List _equation = [];
    _equation.add('x');
    _equation.add('=');
    _equation.add('?');
    _equation.removeWhere((element) => element == '');
    return _equation;
  }
}
