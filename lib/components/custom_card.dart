import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_boxshadow.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final double padding;
  final double columnGap;

  CustomCard({
    this.child,
    this.color,
    this.padding = 16.0,
    this.columnGap = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.symmetric(
        horizontal: columnGap,
        vertical: columnGap / 2,
      ),
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
