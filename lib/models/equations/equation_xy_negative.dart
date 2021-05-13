import 'package:jogo_das_equacoes/models/equations/equation_abstract.dart';

class EquationXYnegative extends Equation {
  int _firstNumber;
  int _secondNumber;

  @override
  List getEquations() {
    List _equation = [];
    _firstNumber = random.positiveNumber(max: 10);
    _secondNumber = random.positiveNumber(max: 10);
    _equation.add(_getEquation1());
    _equation.add(_getEquation2());
    _equation.add(_getEquation3());
    return _equation;
  }

  @override
  int getResultOfTheEquation() {
    return _secondNumber + _firstNumber;
  }

  List _getEquation1() {
    return ['y', '=', _firstNumber.toString()];
  }

  List _getEquation2() {
    return ['x', '-', 'y', '=', _secondNumber.toString()];
  }

  List _getEquation3() {
    return ['x', '=', '?'];
  }
}
