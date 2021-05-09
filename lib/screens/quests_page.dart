import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/quest.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/components/score.dart';
import 'package:jogo_das_equacoes/models/consts.dart';
import 'package:jogo_das_equacoes/providers/player_status.dart';
import 'package:jogo_das_equacoes/screens/stage_help_page.dart';
import 'package:provider/provider.dart';

class QuestsPage extends StatelessWidget {
  final int stage;

  const QuestsPage({@required this.stage});

  @override
  Widget build(BuildContext context) {
    int numberOfRows = NUMBER_OF_QUESTS_IN_EACH_STAGE ~/ 5; //2 linhas
    int numberOfColumns = NUMBER_OF_QUESTS_IN_EACH_STAGE ~/ 2; //5 colunas
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Fase $stage: Missões'),
        actions: <Widget>[
          Score(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _getQuests(context, stage, numberOfRows, numberOfColumns),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment(1.0, 0.25),
            child: FloatingActionButton(
              heroTag: 'increment quest',
              child: Icon(Icons.add),
              onPressed: () {
                Provider.of<PlayerStatusProvider>(context, listen: false)
                    .incrementQuest();
              },
            ),
          ),
          Align(
            alignment: Alignment(-0.90, 0.25),
            child: FloatingActionButton(
              heroTag: 'decrease quest',
              child: Icon(Icons.remove),
              onPressed: () {
                PlayerStatusProvider _playerStatusProvider =
                    Provider.of<PlayerStatusProvider>(context, listen: false);
                _playerStatusProvider.decreaseQuest();
                _playerStatusProvider.resetScore();
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: 'help button',
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.help,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StageHelp(stage: stage),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> _getQuests(
    BuildContext context, int stage, int rows, int columns) {
  List<Widget> listQuests = [];
  for (var row = 0; row < rows; row++) {
    List<Widget> rowQuests = [];
    for (var column = 0; column < columns; column++) {
      int title = (columns * row + column + 1) + (stage - 1) * 10;
      rowQuests.add(
        Consumer<PlayerStatusProvider>(
          builder: (context, playerStatus, child) {
            return Quest(
              isEnable: title <= playerStatus.getQuest() ? true : false,
              title: '$title',
              width: (MediaQuery.of(context).size.longestSide -
                      32 * (columns + 1)) /
                  columns,
              height: (MediaQuery.of(context).size.shortestSide -
                      32 * (rows + 1) -
                      kToolbarHeight) /
                  rows, //kToolbarHeight é a altura da AppBar 32 é o espaço entre os elementos
            );
          },
        ),
      );
    }
    listQuests.add(
      Row(children: rowQuests),
    );
  }
  return listQuests;
}
