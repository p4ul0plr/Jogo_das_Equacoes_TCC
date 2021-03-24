import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;

  const Header({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Ink(
                decoration: ShapeDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Text(
                'Sair',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Schoolbell',
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Schoolbell',
                ),
              ),
            ],
          ),
          Container(),
        ],
      ),
    );
  }
}
