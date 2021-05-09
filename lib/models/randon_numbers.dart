import 'dart:math';

import 'package:flutter/material.dart';

class RandomNumbers {
  int positiveNumber({@required int max}) {
    return 1 + Random().nextInt(max);
  }

  int negativeNumber({@required int max}) {
    return -1 * positiveNumber(max: max);
  }

  int negativePositiveNumber({@required int max}) {
    bool sign = Random().nextBool();
    if (sign) {
      return 1 + Random().nextInt(max);
    }
    return -1 * (1 + Random().nextInt(max));
  }

  String mathematicalSign({
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
