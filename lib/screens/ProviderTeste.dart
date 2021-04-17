import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/providers/player_status.dart';
import 'package:provider/provider.dart';

class ProviderTeste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privider Teste'),
      ),
      body: Consumer<PlayerStatusProvider>(
        builder: (context, playerStatus, child) {
          return Container(
            alignment: Alignment.center,
            child: returnTexts(playerStatus),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Provider.of<PlayerStatusProvider>(context, listen: false)
              .incrementScore(100);
          Provider.of<PlayerStatusProvider>(context, listen: false)
              .incrementQuest();
        },
      ),
    );
  }

  Column returnTexts(PlayerStatusProvider playerStatus) {
    if (playerStatus.getScore() < 1000) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Score: ${playerStatus.getScore()}'),
          Text('Quest: ${playerStatus.getQuest()}'),
          Text('Stage: ${playerStatus.getStage()}'),
        ],
      );
    }
    return null;
  }
}
