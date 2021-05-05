import 'package:flutter/cupertino.dart';
import 'package:jogo_das_equacoes/models/equarions/equation.dart';

class EquationXpositiveNegative extends Equation {
  int _firstNumber;
  int _secondNumber;

  EquationXpositiveNegative() {
    _firstNumber = negativePositiveRandomNumber(max: 10);
    _secondNumber = negativePositiveRandomNumber(max: 10);
  }

  @override
  List getEquation() {
    equation.add('x');
    equation.add(generateMathematicalSignWithNumber(
      number: _firstNumber,
      signalPositive: true,
    ));
    equation.add(numberModule(number: _firstNumber).toString());
    equation.add('=');
    equation.add(generateMathematicalSignWithNumber(
      number: _secondNumber,
      signalPositive: false,
    ));
    equation.add(numberModule(number: _secondNumber).toString());
    equation.remove('');
    return equation;
  }

  int numberModule({@required int number}) => number < 0 ? number * -1 : number;

  @override
  int getResultOfTheEquation() {
    resultOfTheEquation = _firstNumber * -1 + _secondNumber;
    return resultOfTheEquation;
  }
}
