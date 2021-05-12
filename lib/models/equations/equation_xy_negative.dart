import 'package:jogo_das_equacoes/models/equations/equation_abstract.dart';

class EquationXYnegative extends Equation {
  int _firstNumber;
  int _secondNumber;

  @override
  List getEquations() {
    List _equation = [];
    _firstNumber = random.positiveNumber(max: 10);
    _secondNumber = random.positiveNumber(max: 10);
    _equation.add(_getEquation1(_firstNumber));
    _equation.add(_getEquation2(_secondNumber));
    _equation.add(_getEquation3());
    return _equation;
  }

  @override
  int getResultOfTheEquation() {
    return (_secondNumber - _firstNumber) * (-1);
  }

  List _getEquation1(int number) {
    return ['y', '=', number.toString()];
  }

  List _getEquation2(int number) {
    return ['x', '-', 'y', '=', number.toString()];
  }

  List _getEquation3() {
    return ['x', '=', '?'];
  }
}
