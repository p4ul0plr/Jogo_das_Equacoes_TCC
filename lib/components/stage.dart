import 'package:flutter/material.dart';

class Stage extends StatelessWidget {
  final String title;
  final double width;
  final double height;

  Stage({this.title, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        /* margin: EdgeInsets.only(
          top: 32.0,
          left: 32.0,
          bottom: 32.0,
          right: i == (numberOfStages - 1) ? 32.0 : 0),
      width: (MediaQuery.of(context).size.longestSide - 32 * 5) / 4,
      child: Material(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => QuestsPage(stage: i + 1),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${i + 1}',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Schoolbell',
                ),
              ),
            ],
          ),
        ),
      ), */
        );
  }
}
