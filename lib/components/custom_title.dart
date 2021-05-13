import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final title;

  CustomTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 40,
        fontFamily: 'Schoolbell',
      ),
    );
  }
}
