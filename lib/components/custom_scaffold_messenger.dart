import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/models/colors.dart';

void customScaffoldMessenger({
  String text,
  BuildContext context,
  bool success,
  SnackBarAction action,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(
          fontFamily: 'Schoolbell',
          fontSize: 16.0,
        ),
      ),
      backgroundColor: success ? ThemeColors().blue : ThemeColors().pink,
      duration: Duration(seconds: 5),
      action: action,
    ),
  );
}
