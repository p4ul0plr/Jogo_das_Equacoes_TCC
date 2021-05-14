import 'package:flutter/material.dart';

class CustomBoxShadow extends BoxShadow {
  final Color color = Colors.grey.withOpacity(0.7);
  final double spreadRadius = 1;
  final double blurRadius = 10;
  final Offset offset = Offset(0, 3);
  CustomBoxShadow() {
    BoxShadow(
      color: color,
      spreadRadius: spreadRadius,
      blurRadius: blurRadius,
      offset: offset, // changes position of shadow
    );
  }
}
