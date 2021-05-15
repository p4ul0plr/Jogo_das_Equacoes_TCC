import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_boxshadow.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color color;

  CustomCard({this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          CustomBoxShadow(),
        ],
      ),
      child: child,
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;

  CustomText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'Schoolbell',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
