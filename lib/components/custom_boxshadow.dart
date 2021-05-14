import 'package:flutter/material.dart';

class CustomBoxShadow extends BoxShadow {
  final Color color = Colors.grey.withOpacity(0.5);
  final double spreadRadius = 1;
  final double blurRadius = 10;
  final Offset offset = Offset(0, 3);
  CustomBoxShadow() {
    BoxShadow(
      color: Colors.grey.withOpacity(0.7),
      spreadRadius: 1,
      blurRadius: 10,
      offset: Offset(0, 3), // changes position of shadow
    );
  }
}
