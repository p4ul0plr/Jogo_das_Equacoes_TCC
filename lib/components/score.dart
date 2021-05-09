import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/providers/player_status.dart';
import 'package:provider/provider.dart';

class Score extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerStatusProvider>(
      builder: (context, playerStatus, child) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              'Pontuação: ' + playerStatus.getScore().toString(),
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Schoolbell',
              ),
            ),
          ),
        );
      },
    );
  }
}
