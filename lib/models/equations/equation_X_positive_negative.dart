import 'package:flutter/cupertino.dart';
import 'package:jogo_das_equacoes/models/equations/equation_abstract.dart';

class EquationXpositiveNegative extends Equation {
  int _firstNumber;
  int _secondNumber;

  EquationXpositiveNegative() {
    _firstNumber = negativePositiveRandomNumber(max: 10);
    _secondNumber = negativePositiveRandomNumber(max: 10);
  }

  @override
  List getEquations() {
    List _equation1 = [];
    List _equation2 = ['x', '=', '?'];
    _equation1.add('x');
    _equation1.add(generateMathematicalSignWithNumber(
      number: _firstNumber,
      signalPositive: true,
    ));
    _equation1.add(numberModule(number: _firstNumber).toString());
    _equation1.add('=');
    _equation1.add(generateMathematicalSignWithNumber(
      number: _secondNumber,
      signalPositive: false,
    ));
    _equation1.add(numberModule(number: _secondNumber).toString());
    _equation1.remove('');
    equation.add(_equation1);
    equation.add(_equation2);
    return equation;
  }

  int numberModule({@required int number}) => number < 0 ? number * -1 : number;

  @override
  int getResultOfTheEquation() {
    resultOfTheEquation = _firstNumber * -1 + _secondNumber;
    return resultOfTheEquation;
  }
}
