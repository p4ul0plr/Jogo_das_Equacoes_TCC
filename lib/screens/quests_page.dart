import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/quest.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/models/player_status.dart';
import 'package:jogo_das_equacoes/screens/stage_help_page.dart';
import 'package:provider/provider.dart';

class QuestsPage extends StatelessWidget {
  final int stage;

  const QuestsPage({@required this.stage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Fase $stage: Missões'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help),
            tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StageHelp(stage: stage),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _getQuests(context, stage, 2, 5),
        ),
      ),
      floatingActionButton: Center(
        heightFactor: 5,
        widthFactor: 0.5,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Provider.of<PlayerStatus>(context, listen: false).increaseQuest();
          },
        ),
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
        Consumer<PlayerStatus>(
          builder: (context, playerStatus, child) {
            return Quest(
              isEnable: title <= playerStatus.quest ? true : false,
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
