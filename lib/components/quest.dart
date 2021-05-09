import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/screens/game_match_page.dart';

class Quest extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final bool isEnable;

  Quest({this.title, this.width, this.height, this.isEnable});

  @override
  Widget build(BuildContext context) {
    if (isEnable) {
      return Container(
        margin: EdgeInsets.all(8.0),
        width: width,
        height: height,
        child: Material(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GameMatchPage(quest: title),
                ),
              );
            },
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Schoolbell',
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(8.0),
        width: width,
        height: height,
        child: Material(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GameMatchPage(quest: title),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 30,
                    fontFamily: 'Schoolbell',
                  ),
                ),
                Icon(
                  Icons.lock,
                  color: Colors.grey[400],
                  size: 50,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
