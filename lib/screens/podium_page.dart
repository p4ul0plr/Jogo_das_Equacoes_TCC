import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_alert_dialog.dart';
import 'package:jogo_das_equacoes/components/custom_card.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/database/dao/player_dao.dart';
import 'package:jogo_das_equacoes/models/colors.dart';
import 'package:jogo_das_equacoes/models/player.dart';
import 'package:jogo_das_equacoes/providers/player.dart';
import 'package:provider/provider.dart';

class PodiumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Pódio'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          children: [
            StreamBuilder(
              stream: PlayerDao().readfirstPlaced(),
              builder: (context, snapshot) => _firstPlaced(context, snapshot),
            ),
            StreamBuilder(
              stream: PlayerDao().readlastPlaced(),
              builder: (context, snapshot) => _lastPlaced(context, snapshot),
            ),
          ],
        ),
      ),
    );
  }

  _firstPlaced(
    BuildContext context,
    AsyncSnapshot<dynamic> snapshot,
  ) {
    List<Player> listPlayers = [];
    if (snapshot.hasData) {
      listPlayers = snapshot.data;

      int placed = _getPlaced(listPlayers, context);
      return Expanded(
        flex: 1,
        child: Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _getPlacement(
                context: context,
                listPlayers: listPlayers,
                playerPlacement: 2,
                currentPlayer: placed,
              ),
              _getPlacement(
                context: context,
                listPlayers: listPlayers,
                playerPlacement: 1,
                currentPlayer: placed,
              ),
              _getPlacement(
                context: context,
                listPlayers: listPlayers,
                playerPlacement: 3,
                currentPlayer: placed,
              ),
            ],
          ),
        ),
      );
    }
    return CircularProgressIndicator();
  }

  int _getPlaced(List<Player> listPlayers, BuildContext context) {
    var currentPlayer =
        Provider.of<PlayerProvider>(context, listen: false).player;
    int placed = 0;
    for (var i = 0; i < listPlayers.length; i++) {
      if (listPlayers[i].id == currentPlayer.id) {
        placed = i + 1;
      }
    }
    return placed;
  }

  Widget _getPlacement({
    BuildContext context,
    List<Player> listPlayers,
    int playerPlacement,
    int currentPlayer,
  }) {
    Player player;
    String name = 'Sem dados';
    String score = 'Sem dados';
    String quest = 'Sem dados';
    String stage = 'Sem dados';
    String gender = 'Sem dados';
    String grade = 'Sem dados';
    String school = 'Sem dados';

    Color cardColor;
    if (listPlayers.length >= playerPlacement) {
      player = listPlayers[playerPlacement - 1];
      score = player.playerStatus.score.toString();
      quest = player.playerStatus.quest.toString();
      stage = player.playerStatus.stage.toString();
      name = player.name;
      gender = player.gender;
      grade = player.grade;
      school = player.school;
      /* if (name.length > 15) {
        name = name.substring(0, 15) + '...';
      } */
    }
    switch (playerPlacement) {
      case 1:
        cardColor = ThemeColors().yellow;
        break;
      case 2:
        cardColor = ThemeColors().blue;
        break;
      case 3:
        cardColor = ThemeColors().green;
        break;
      default:
        cardColor = ThemeColors().lightBlue;
        break;
    }
    return Expanded(
      child: CustomCard(
        onTap: () => showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              playerPlacement: playerPlacement.toString(),
              name: name,
              score: score,
              stage: stage,
              quest: quest,
              gender: gender,
              grade: grade,
              school: school,
            );
          },
        ),
        currentPlayer: playerPlacement == currentPlayer,
        padding: 8.0,
        columnGap: 8.0,
        color: cardColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            playerPlacement == 1
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$playerPlacementº\nLugar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Schoolbell',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$playerPlacementº Lugar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Schoolbell',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$name',
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Schoolbell',
                      ),
                    ),
                    Text(
                      '$score pontos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Schoolbell',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _lastPlaced(
    BuildContext context,
    AsyncSnapshot<dynamic> snapshot,
  ) {
    List<Widget> _placedListRow = [];
    List<Widget> _placedListColumn = [];
    Widget _placedRow;
    Widget _placedColumn;
    int playerPlacement;
    String name = 'Sem dados';
    String score = 'Sem dados';
    String quest = 'Sem dados';
    String stage = 'Sem dados';
    String gender = 'Sem dados';
    String grade = 'Sem dados';
    String school = 'Sem dados';
    List<Player> listPlayers = [];
    int placed;
    if (snapshot.hasData) {
      listPlayers = snapshot.data;
      placed = _getPlaced(listPlayers, context);
      for (var j = 0; j < 3; j++) {
        _placedListRow = [];
        for (var i = 0; i < 3; i++) {
          playerPlacement = i + 4 + (j * 3);
          Player player = listPlayers[playerPlacement - 1];
          name = player.name;
          quest = player.playerStatus.quest.toString();
          stage = player.playerStatus.stage.toString();
          name = player.name;
          gender = player.gender;
          grade = player.grade;
          school = player.school;
          /* if (name.length > 10) {
            name =
                listPlayers[playerPlacement - 1].name.substring(0, 10) + '...';
          } */
          score = player.playerStatus.score.toString();
          _placedListRow.add(
            Expanded(
              child: CustomCard(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                      playerPlacement: playerPlacement.toString(),
                      name: name,
                      score: score,
                      stage: stage,
                      quest: quest,
                      gender: gender,
                      grade: grade,
                      school: school,
                    );
                  },
                ),
                currentPlayer: placed == playerPlacement,
                padding: 4.0,
                columnGap: 8.0,
                color: ThemeColors().lightBlue,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            '$playerPlacementº Lugar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Schoolbell',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2.0,
                            ),
                            child: Text(
                              '$name',
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Schoolbell',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Text(
                              '$score pontos',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Schoolbell',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        _placedRow = Expanded(
          child: Row(
            children: _placedListRow,
          ),
        );
        _placedListColumn.add(_placedRow);
      }

      _placedColumn = Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _placedListColumn,
      );
      return Expanded(
        flex: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: _placedColumn,
        ),
      );
    }
    return CircularProgressIndicator();
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key key,
    @required this.name,
    @required this.score,
    @required this.stage,
    @required this.quest,
    @required this.gender,
    @required this.grade,
    @required this.school,
    @required this.playerPlacement,
  }) : super(key: key);

  final String name;
  final String score;
  final String stage;
  final String quest;
  final String gender;
  final String grade;
  final String school;
  final String playerPlacement;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      title: Column(
        children: [
          Text(
            '$playerPlacementº lugar - $name',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Schoolbell',
            ),
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            textAlign: TextAlign.center,
          ),
          Text(
            '$score pontos',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Schoolbell',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: CustomDataTable(
          stage: stage,
          quest: quest,
          gender: gender,
          grade: grade,
          school: school,
        ),
      ),
    );
  }
}

class CustomDataTable extends StatelessWidget {
  const CustomDataTable({
    Key key,
    @required this.quest,
    @required this.gender,
    @required this.grade,
    @required this.school,
    @required this.stage,
  }) : super(key: key);

  final String quest;
  final String stage;
  final String gender;
  final String grade;
  final String school;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: CustomDataColumnLabel(text: 'Informações')),
        DataColumn(label: CustomDataColumnLabel(text: 'Dados')),
      ],
      rows: [
        DataRow(
          cells: [
            DataCell(
              CustomDataCellText(text: 'Missões'),
            ),
            DataCell(
              CustomDataCellText(text: '$quest'),
            ),
          ],
        ),
        DataRow(
          cells: [
            DataCell(
              CustomDataCellText(text: 'Fases'),
            ),
            DataCell(
              CustomDataCellText(text: '$stage'),
            ),
          ],
        ),
        DataRow(
          cells: [
            DataCell(
              CustomDataCellText(text: 'Sexo'),
            ),
            DataCell(
              CustomDataCellText(text: '$gender'),
            ),
          ],
        ),
        DataRow(
          cells: [
            DataCell(
              CustomDataCellText(text: 'Série'),
            ),
            DataCell(
              CustomDataCellText(text: '$grade'),
            ),
          ],
        ),
        DataRow(
          cells: [
            DataCell(
              CustomDataCellText(text: 'Escola'),
            ),
            DataCell(
              CustomDataCellText(text: '$school'),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomDataCellText extends StatelessWidget {
  final String text;
  const CustomDataCellText({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
      ),
    );
  }
}

class CustomDataColumnLabel extends StatelessWidget {
  final String text;
  const CustomDataColumnLabel({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
