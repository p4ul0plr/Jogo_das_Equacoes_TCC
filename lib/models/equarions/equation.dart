import 'dart:math';

import 'package:flutter/material.dart';

enum EvenOrOddNumber {
  evenNumber,
  oddNumber,
  any,
}

abstract class Equation {
  List<String> equation = [];
  int resultOfTheEquation;

  List<String> getEquation();

  int getResultOfTheEquation();

  String generatePositiveRandomNumber({@required int max}) {
    return '${1 + Random().nextInt(max)}';
  }

  String generateNegativeRandomNumber({@required int max}) {
    return '${-1 * int.parse(generatePositiveRandomNumber(max: max))}';
  }
}
