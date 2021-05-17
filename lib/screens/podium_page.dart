import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_card.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/database/dao/player_dao.dart';
import 'package:jogo_das_equacoes/models/colors.dart';
import 'package:jogo_das_equacoes/models/player.dart';
import 'package:jogo_das_equacoes/providers/player.dart';
import 'package:provider/provider.dart';

class PodiumPage extends StatefulWidget {
  @override
  _PodiumPageState createState() => _PodiumPageState();
}

class _PodiumPageState extends State<PodiumPage> {
  Player currentPlayer;

  @override
  void initState() {
    currentPlayer = Provider.of<PlayerProvider>(context, listen: false).player;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Pódio'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: PlayerDao().readAll(),
        builder: (context, snapshot) {
          List<Player> listPlayers = _getPlayers(context, snapshot);
          return Column(
            children: [
              _firstPlacedCard(listPlayers),
              _lastPlaced(listPlayers),
            ],
          );
        },
      ),
    );
  }

  List<Player> _getPlayers(
    BuildContext context,
    AsyncSnapshot<dynamic> snapshot,
  ) {
    if (snapshot.hasData) {
      List<Player> listPlayers = snapshot.data;
      listPlayers.sort(
        (a, b) => b.playerStatus.score.compareTo(a.playerStatus.score),
      );
      listPlayers.forEach((element) {
        print(element.playerStatus.score);
      });
      return listPlayers;
    }
    return [];
  }

  Widget _firstPlacedCard(List<Player> listPlayers) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(top: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _getPlacement(listPlayers: listPlayers, playerPlacement: 2),
            _getPlacement(listPlayers: listPlayers, playerPlacement: 1),
            _getPlacement(listPlayers: listPlayers, playerPlacement: 3),
          ],
        ),
      ),
    );
  }

  Widget _getPlacement({List<Player> listPlayers, int playerPlacement}) {
    Player player;
    String name = 'Sem dados';
    String score = 'Sem dados';
    Color cardColor;
    int listPlayersLength = 0;
    listPlayers.forEach((element) {
      listPlayersLength++;
    });
    if (listPlayersLength >= playerPlacement) {
      player = listPlayers[playerPlacement - 1];
      name = player.name;
      score = player.playerStatus.score.toString();
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
        color: cardColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            playerPlacement == 1
                ? Text(
                    '$playerPlacementº\nLugar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Schoolbell',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  )
                : Text(
                    '$playerPlacementº Lugar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Schoolbell',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Nome: $name'),
                  Text('Pontos: $score'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lastPlaced(List<Player> listPlayers) {
    List<Widget> _placedListRow = [];
    List<Widget> _placedListColumn = [];
    Widget _placedRow;
    Widget _placedColumn;
    for (var j = 0; j < 3; j++) {
      _placedListRow = [];
      for (var i = 0; i < 3; i++) {
        _placedListRow.add(
          Expanded(
            child: CustomCard(
              color: ThemeColors().lightBlue,
              child: Text(
                '${i + 4 + (j * 3)}º Lugar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Schoolbell',
                  fontWeight: FontWeight.bold,
                ),
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
}
