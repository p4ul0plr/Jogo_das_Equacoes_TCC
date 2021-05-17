import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/models/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final void Function() cancelOnPressed;
  final void Function() confirmOnPressed;
  final String text;

  CustomAlertDialog({
    this.cancelOnPressed,
    this.confirmOnPressed,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 24.0,
          fontFamily: 'Schoolbell',
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          child: Text(
            'Cancelar',
            style: TextStyle(
              fontSize: 14.0,
              color: ThemeColors().pink,
            ),
          ),
          onPressed: cancelOnPressed,
        ),
        TextButton(
          child: Text(
            'Confirmar',
            style: TextStyle(
              fontSize: 14.0,
              color: ThemeColors().pink,
            ),
          ),
          onPressed: confirmOnPressed,
        ),
      ],
    );
  }
}
