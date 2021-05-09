import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/models/equations/equation_x_negative.dart';
import 'package:jogo_das_equacoes/models/equations/equation_x_positive.dart';
import 'package:jogo_das_equacoes/models/equations/equation_x_positive_negative.dart';

enum EvenOrOddNumber {
  evenNumber,
  oddNumber,
  any,
}

class TestenumerosAleatorios extends StatefulWidget {
  @override
  _TestenumerosAleatoriosState createState() => _TestenumerosAleatoriosState();
}

class _TestenumerosAleatoriosState extends State<TestenumerosAleatorios> {
  EquationXpositive _equationXpositive;
  EquationXnegative _equationXnegative;
  EquationXpositiveNegative _equationXpositiveNegative;
  //List<String> _equationXpositive = [];
  //List<String> _equationXnegative = [];
  //List<String> _equationXpositiveNegative = [];

  @override
  void initState() {
    super.initState();
    _equationXpositive = EquationXpositive();
    _equationXnegative = EquationXnegative();
    _equationXpositiveNegative = EquationXpositiveNegative();
    //_equationWithOneUnknownWithPositiveSigns();
    /* _equationWithOneUnknownWithNegativeSigns();
    _equationWithOneUnknownWithPositiveNegativeSigns();
    _equationWithOneUnknownWithMultiplicationPositiveSigns();
    _equationWithOneUnknownWithMultiplicationNegativeSigns(); */
  }

/*   void _equationWithOneUnknownWithPositiveSigns() {
    String firstNumber = _generatePositiveRandomNumber(
      max: 10,
      evenOrOddNumber: EvenOrOddNumber.any,
    );
    String secondNumber = _generatePositiveRandomNumber(
      max: 10,
      evenOrOddNumber: EvenOrOddNumber.any,
    );
    _equationXpositive.clear();
    _equationXpositive.add('x');
    _equationXpositive.add('+');
    _equationXpositive.add(firstNumber);
    _equationXpositive.add('=');
    _equationXpositive.add(secondNumber);
    print('$firstNumber $secondNumber');
  } */

  /* void _equationWithOneUnknownWithNegativeSigns() {
    _equationXnegative.clear();
    _equationXnegative.add('x');
    _equationXnegative.add('-');
    _equationXnegative.add(_generatePositiveRandomNumber(max: 10));
    _equationXnegative.add('=');
    _equationXnegative.add(_generatePositiveRandomNumber(max: 10));
  } */

/*   void _equationWithOneUnknownWithPositiveNegativeSigns() {
    _equationXpositiveNegative.clear();
    _equationXpositiveNegative.add('x');
    _equationXpositiveNegative
        .add(_generateMathematicalSign(signalPositive: true));
    _equationXpositiveNegative.add(_generatePositiveRandomNumber(max: 10));
    _equationXpositiveNegative.add('=');
    _equationXpositiveNegative
        .add(_generateMathematicalSign(signalPositive: false));
    _equationXpositiveNegative.add(_generatePositiveRandomNumber(max: 10));
    _equationXpositiveNegative.remove('');
  } */
  //2*x+4=6
  List _equationWithOneUnknownWithMultiplicationPositiveSigns() {
    List _equation = [];
    int _firstNumber;
    int _secondNumber;
    int _thirdNumber;
    bool _itIsNotDivisible;
    bool _notNullNumerator;
    do {
      _firstNumber = 1 +
          _generatePositiveRandomNumber(
            max: 9,
            evenOrOddNumber: EvenOrOddNumber.any,
          );
      _secondNumber = _generatePositiveRandomNumber(
        max: 10,
        evenOrOddNumber: EvenOrOddNumber.any,
      );
      _thirdNumber = _generatePositiveRandomNumber(
        max: 10,
        evenOrOddNumber: EvenOrOddNumber.any,
      );
      _itIsNotDivisible = (_thirdNumber - _secondNumber) % _firstNumber != 0;
      _notNullNumerator = _secondNumber == _thirdNumber;
    } while (_itIsNotDivisible || _notNullNumerator);
    _equation.add(_firstNumber);
    _equation.add('*');
    _equation.add('x');
    _equation.add('+');
    _equation.add(_secondNumber);
    _equation.add('=');
    _equation.add(_thirdNumber);
    print((_thirdNumber - _secondNumber) ~/ _firstNumber);
    return _equation;
  }

  List _equationWithOneUnknownWithMultiplicationNegativeSigns() {
    List _equation = [];
    int _firstNumber;
    int _secondNumber;
    int _thirdNumber;
    bool _itIsNotDivisible;
    do {
      _firstNumber = 1 +
          _generatePositiveRandomNumber(
            max: 9,
            evenOrOddNumber: EvenOrOddNumber.any,
          );
      _secondNumber = _generatePositiveRandomNumber(
        max: 10,
        evenOrOddNumber: EvenOrOddNumber.any,
      );
      _thirdNumber = _generatePositiveRandomNumber(
        max: 10,
        evenOrOddNumber: EvenOrOddNumber.any,
      );
      _itIsNotDivisible = (_thirdNumber + _secondNumber) % _firstNumber != 0;
    } while (_itIsNotDivisible);
    _equation.add(_firstNumber);
    _equation.add('*');
    _equation.add('x');
    _equation.add('-');
    _equation.add(_secondNumber);
    _equation.add('=');
    _equation.add(_thirdNumber);
    return _equation;
  }

  List _equationWithOneUnknownWithMultiplicationPositiveNegativeSigns() {
    List _equation = [];
    int _firstNumber;
    int _secondNumber;
    int _thirdNumber;
    bool _itIsNotDivisible;
    bool _notNullNumerator;
    do {
      do {
        _firstNumber = _negativePositiveRandomNumber(
          max: 10,
          evenOrOddNumber: EvenOrOddNumber.any,
        );
      } while (_firstNumber == 1 || _firstNumber == -1);
      _secondNumber = _negativePositiveRandomNumber(
        max: 10,
        evenOrOddNumber: EvenOrOddNumber.any,
      );
      _thirdNumber = _negativePositiveRandomNumber(
        max: 10,
        evenOrOddNumber: EvenOrOddNumber.any,
      );
      _itIsNotDivisible =
          (_thirdNumber + (-1 * _secondNumber)) % _firstNumber != 0;
      _notNullNumerator = _secondNumber == _thirdNumber;
    } while (_itIsNotDivisible || _notNullNumerator);
    _equation.add(_generateMathematicalSign(
      number: _firstNumber,
      signalPositive: false,
    ));
    _equation.add(_numberModule(number: _firstNumber).toString());
    _equation.add('*');
    _equation.add('x');
    _equation.add(_generateMathematicalSign(
      number: _secondNumber,
      signalPositive: true,
    ));
    _equation.add(_numberModule(number: _secondNumber).toString());
    _equation.add('=');
    _equation.add(_generateMathematicalSign(
      number: _thirdNumber,
      signalPositive: false,
    ));
    _equation.add(_numberModule(number: _thirdNumber).toString());
    _equation.removeWhere((element) => element == '');
    return _equation;
  }

  int _numberModule({@required int number}) =>
      number < 0 ? number * -1 : number;

  String _generateMathematicalSign({
    @required int number,
    @required bool signalPositive,
  }) {
    if (number >= 0 && signalPositive) {
      return '+';
    } else if (number < 0) {
      return '-';
    }
    return '';
  }

/*   String _generateMathematicalSign({@required bool signalPositive}) {
    bool mathematicalSign = Random().nextBool();
    if (mathematicalSign && signalPositive) {
      return '+';
    } else if (!mathematicalSign) {
      return '-';
    }
    return '';
  } */

  int _generatePositiveRandomNumber(
      {@required int max, @required EvenOrOddNumber evenOrOddNumber}) {
    int _result = 1 + Random().nextInt(max);
    switch (evenOrOddNumber) {
      case EvenOrOddNumber.any:
        return _result;
      case EvenOrOddNumber.evenNumber: //par
        while (_result % 2 != 0) {
          _result = 1 + Random().nextInt(max);
        }
        return _result;
        break;
      case EvenOrOddNumber.oddNumber: //impar
        while (_result % 2 == 0) {
          _result = 1 + Random().nextInt(max);
        }
        return _result;
        break;
      default:
        return null;
    }
  }

  String _generateNegativeRandomNumber(
      {@required int max, @required EvenOrOddNumber evenOrOddNumber}) {
    int _result = -1 * (1 + Random().nextInt(max));
    switch (evenOrOddNumber) {
      case EvenOrOddNumber.any:
        return _result.toString();
      case EvenOrOddNumber.evenNumber: //par
        while (_result % 2 != 0) {
          _result = -1 * (1 + Random().nextInt(max));
        }
        return _result.toString();
        break;
      case EvenOrOddNumber.oddNumber: //impar
        while (_result % 2 == 0) {
          _result = -1 * (1 + Random().nextInt(max));
        }
        return _result.toString();
        break;
      default:
        return null;
    }
  }

  int _negativePositiveRandomNumber({
    @required int max,
    @required EvenOrOddNumber evenOrOddNumber,
  }) {
    int _result;
    bool _sign = Random().nextBool();
    if (_sign) {
      _result = 1 + Random().nextInt(max);
    } else {
      _result = -1 * (1 + Random().nextInt(max));
    }
    switch (evenOrOddNumber) {
      case EvenOrOddNumber.any:
        return _result;
      case EvenOrOddNumber.evenNumber: //par
        while (_result % 2 != 0) {
          _sign = Random().nextBool();
          if (_sign) {
            _result = 1 + Random().nextInt(max);
          } else {
            _result = -1 * (1 + Random().nextInt(max));
          }
        }
        return _result;
        break;
      case EvenOrOddNumber.oddNumber: //impar
        while (_result % 2 == 0) {
          _sign = Random().nextBool();
          if (_sign) {
            _result = 1 + Random().nextInt(max);
          } else {
            _result = -1 * (1 + Random().nextInt(max));
          }
        }
        return _result;
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Número aleatório'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Equação: ${_equationXpositive.getEquations()}'),
              Text('Resposta: ${_equationXpositive.getResultOfTheEquation()}'),
              Text('Equação: ${_equationXnegative.getEquations()}'),
              Text('Resposta: ${_equationXnegative.getResultOfTheEquation()}'),
              Text('Equação: ${_equationXpositiveNegative.getEquations()}'),
              Text(
                  'Resposta: ${_equationXpositiveNegative.getResultOfTheEquation()}'),
              Text(
                  'Equação (Multiplicação|Positivo): ${_equationWithOneUnknownWithMultiplicationPositiveSigns()}'),
              Text(
                  'Equação (Multiplicação|Negativo): ${_equationWithOneUnknownWithMultiplicationNegativeSigns()}'),
              Text(
                  'Equação (Multiplicação|Positivo-Negativo): ${_equationWithOneUnknownWithMultiplicationPositiveNegativeSigns()}'),
              Text(
                'Número par positivo: ${_generatePositiveRandomNumber(
                  max: 10,
                  evenOrOddNumber: EvenOrOddNumber.evenNumber,
                )}',
              ),
              Text(
                'Número impar positivo: ${_generatePositiveRandomNumber(
                  max: 10,
                  evenOrOddNumber: EvenOrOddNumber.oddNumber,
                )}',
              ),
              Text(
                'Número positivo: ${_generatePositiveRandomNumber(
                  max: 10,
                  evenOrOddNumber: EvenOrOddNumber.any,
                )}',
              ),
              Text(
                'Número par negativo: ${_generateNegativeRandomNumber(
                  max: 10,
                  evenOrOddNumber: EvenOrOddNumber.evenNumber,
                )}',
              ),
              Text(
                'Número impar negativo: ${_generateNegativeRandomNumber(
                  max: 10,
                  evenOrOddNumber: EvenOrOddNumber.oddNumber,
                )}',
              ),
              Text(
                'Número negativo: ${_generateNegativeRandomNumber(
                  max: 10,
                  evenOrOddNumber: EvenOrOddNumber.any,
                )}',
              ),
              Text(
                'Número positivo ou negativo: ${_negativePositiveRandomNumber(
                  max: 10,
                  evenOrOddNumber: EvenOrOddNumber.any,
                )}',
              ),
              Text(
                'Número positivo ou negativo par: ${_negativePositiveRandomNumber(
                  max: 10,
                  evenOrOddNumber: EvenOrOddNumber.evenNumber,
                )}',
              ),
              Text(
                'Número positivo ou negativo impar: ${_negativePositiveRandomNumber(
                  max: 10,
                  evenOrOddNumber: EvenOrOddNumber.oddNumber,
                )}',
              ),
              /* Text('Equação: $_equationXpositive'),
              Text('Equação: $_equationXnegative'),
              Text('Equação: $_equationXpositiveNegative'),
              Text('Equação: $_equationXmultiplicationPositive'),
              Text('Equação: $_equationXmultiplicationNegative'), */
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _equationXpositive = EquationXpositive();
            _equationXnegative = EquationXnegative();
            _equationXpositiveNegative = EquationXpositiveNegative();
            //_equationWithOneUnknownWithPositiveSigns();
/*             _equationWithOneUnknownWithNegativeSigns();
            _equationWithOneUnknownWithPositiveNegativeSigns();
            _equationWithOneUnknownWithMultiplicationPositiveSigns();
            _equationWithOneUnknownWithMultiplicationNegativeSigns(); */
          });
        },
        child: Icon(Icons.replay_outlined),
      ),
    );
  }
}
