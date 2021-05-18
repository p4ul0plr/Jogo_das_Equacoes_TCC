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
      body: Column(
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
    );
  }

  Widget _firstPlaced(
    BuildContext context,
    AsyncSnapshot<dynamic> snapshot,
  ) {
    Player currentPlayer =
        Provider.of<PlayerProvider>(context, listen: false).player;
    print(currentPlayer);
    List<Player> listPlayers = [];
    if (snapshot.hasData) {
      listPlayers = snapshot.data;
    }
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
    if (listPlayers.length >= playerPlacement) {
      player = listPlayers[playerPlacement - 1];
      score = player.playerStatus.score.toString();
      name = player.name;
      if (name.length > 15) {
        name = name.substring(0, 15) + '...';
      }
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
        padding: 8.0,
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
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Nome: $name\nPontos: $score',
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
          ],
        ),
      ),
    );
  }

  Widget _lastPlaced(
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
    List<Player> listPlayers = [];
    if (snapshot.hasData) {
      listPlayers = snapshot.data;
      for (var j = 0; j < 3; j++) {
        _placedListRow = [];
        for (var i = 0; i < 3; i++) {
          playerPlacement = i + 4 + (j * 3);
          name = listPlayers[playerPlacement - 1].name;
          if (name.length > 10) {
            name =
                listPlayers[playerPlacement - 1].name.substring(0, 10) + '...';
          }
          score =
              listPlayers[playerPlacement - 1].playerStatus.score.toString();
          _placedListRow.add(
            Expanded(
              child: CustomCard(
                padding: 4.0,
                color: ThemeColors().lightBlue,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '$playerPlacementº Lugar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Schoolbell',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Nome: $name',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Schoolbell',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Pontos: $score',
                          style: TextStyle(
                            fontFamily: 'Schoolbell',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
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
