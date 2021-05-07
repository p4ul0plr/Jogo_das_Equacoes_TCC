import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/models/equations/equation_X_negative.dart';
import 'package:jogo_das_equacoes/models/equations/equation_X_positive.dart';
import 'package:jogo_das_equacoes/models/equations/equation_X_positive_negative.dart';

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
  List<String> _equationXmultiplicationPositive = [];
  List<String> _equationXmultiplicationNegative = [];

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

  void _equationWithOneUnknownWithMultiplicationPositiveSigns() {
    _equationXmultiplicationPositive.clear();
    _equationXmultiplicationPositive
        .add(_generatePositiveRandomNumber(max: 3, evenOrOddNumber: null));
    _equationXmultiplicationPositive.add('*');
    _equationXmultiplicationPositive.add('x');
    _equationXmultiplicationPositive.add('+');
    _equationXmultiplicationPositive
        .add(_generatePositiveRandomNumber(max: 10, evenOrOddNumber: null));
    _equationXmultiplicationPositive.add('=');
    _equationXmultiplicationPositive
        .add(_generatePositiveRandomNumber(max: 10, evenOrOddNumber: null));
  }

  void _equationWithOneUnknownWithMultiplicationNegativeSigns() {
    _equationXmultiplicationNegative.clear();
    _equationXmultiplicationNegative
        .add(_generatePositiveRandomNumber(max: 3, evenOrOddNumber: null));
    _equationXmultiplicationNegative.add('*');
    _equationXmultiplicationNegative.add('x');
    _equationXmultiplicationNegative.add('-');
    _equationXmultiplicationNegative
        .add(_generatePositiveRandomNumber(max: 10, evenOrOddNumber: null));
    _equationXmultiplicationNegative.add('=');
    _equationXmultiplicationNegative
        .add(_generatePositiveRandomNumber(max: 10, evenOrOddNumber: null));
  }

  String _generateMathematicalSign({@required bool signalPositive}) {
    bool mathematicalSign = Random().nextBool();
    if (mathematicalSign && signalPositive) {
      return '+';
    } else if (!mathematicalSign) {
      return '-';
    }
    return '';
  }

  String _generatePositiveRandomNumber(
      {@required int max, @required EvenOrOddNumber evenOrOddNumber}) {
    int result = 1 + Random().nextInt(max);
    switch (evenOrOddNumber) {
      case EvenOrOddNumber.any:
        return '$result';
      case EvenOrOddNumber.evenNumber: //par
        if (result % 2 == 0) {
          return '$result';
        } else if (result < max) {
          return '${result + 1}';
        }
        break;
      case EvenOrOddNumber.oddNumber: //impar
        if (result % 2 != 0) {
          return '$result';
        } else if (result < max) {
          return '${result + 1}';
        } else {
          return '${result - 1}';
        }
        break;
      default:
        return '';
    }
    if (result % 2 == 0) {
    } else {}
  }

  String _negativePositiveRandomNumber({@required int max}) {
    return '${-1 * (1 + Random().nextInt(max))}';
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
              Text('Equação: ${_equationXpositive.getEquation()}'),
              Text('Resposta: ${_equationXpositive.getResultOfTheEquation()}'),
              Text('Equação: ${_equationXnegative.getEquation()}'),
              Text('Resposta: ${_equationXnegative.getResultOfTheEquation()}'),
              Text('Equação: ${_equationXpositiveNegative.getEquation()}'),
              Text(
                  'Resposta: ${_equationXpositiveNegative.getResultOfTheEquation()}')
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
