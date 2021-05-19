import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/providers/player.dart';
import 'package:jogo_das_equacoes/providers/player_status_shared.dart';
import 'package:provider/provider.dart';

class Score extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var player = Provider.of<PlayerProvider>(context, listen: false).player;
    if (player != null) {
      return _scoreOfTheLoggedPlayer();
    } else {
      return _scoreOfThenotLoggedPlayer();
    }
  }

  Consumer<PlayerStatusProviderShared> _scoreOfThenotLoggedPlayer() {
    return Consumer<PlayerStatusProviderShared>(
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

  Consumer<PlayerProvider> _scoreOfTheLoggedPlayer() {
    return Consumer<PlayerProvider>(
      builder: (context, playerProvider, child) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              'Pontuação: ' +
                  playerProvider.player.playerStatus.score.toString(),
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
