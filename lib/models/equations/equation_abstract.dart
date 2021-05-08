import 'dart:math';

import 'package:flutter/material.dart';

enum EvenOrOddNumber {
  evenNumber,
  oddNumber,
  any,
}

abstract class Equation {
  List equation = [];
  int resultOfTheEquation;

  List getEquations();

  int getResultOfTheEquation();

  int generatePositiveRandomNumber({@required int max}) {
    return 1 + Random().nextInt(max);
  }

  int generateNegativeRandomNumber({@required int max}) {
    return -1 * generatePositiveRandomNumber(max: max);
  }

  String generateMathematicalSign({@required bool signalPositive}) {
    int mathematicalSign = Random().nextInt(2);
    if (mathematicalSign == 1 && signalPositive) {
      return '+';
    } else if (mathematicalSign == 0) {
      return '-';
    }
    return '';
  }

  int negativePositiveRandomNumber({@required int max}) {
    bool sign = Random().nextBool();
    if (sign) {
      return 1 + Random().nextInt(max);
    }
    return -1 * (1 + Random().nextInt(max));
  }

  String generateMathematicalSignWithNumber({
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
}
