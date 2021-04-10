import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/quest.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/screens/stage_help_page.dart';

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
          children: _getQuests(context, 2, 5),
        ),
      ),
    );
  }
}

List<Widget> _getQuests(BuildContext context, int rows, int columns) {
  List<Widget> listQuests = [];
  for (var row = 0; row < rows; row++) {
    List<Widget> rowQuests = [];
    for (var column = 0; column < columns; column++) {
      rowQuests.add(
        Quest(
          title: '${columns * row + column + 1}',
          width:
              (MediaQuery.of(context).size.longestSide - 32 * (columns + 1)) /
                  columns,
          height: (MediaQuery.of(context).size.shortestSide -
                  32 * (rows + 1) -
                  kToolbarHeight) /
              rows, //kToolbarHeight é a altura da AppBar 32 é o espaço entre os elementos
        ),
      );
    }
    listQuests.add(
      Row(children: rowQuests),
    );
  }
  return listQuests;
}
