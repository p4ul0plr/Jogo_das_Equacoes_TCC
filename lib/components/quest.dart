import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/screens/game_page.dart';

class Quest extends StatelessWidget {
  final String title;
  final double width;
  final double height;

  Quest({this.title, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      width: width,
      height: height,
      child: Material(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => GamePage(quest: title),
              ),
            );
          },
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Schoolbell',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
