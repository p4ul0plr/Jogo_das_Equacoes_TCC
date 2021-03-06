import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_boxshadow.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/components/score.dart';
import 'package:jogo_das_equacoes/database/authentication_service.dart';
import 'package:jogo_das_equacoes/models/colors.dart';
import 'package:jogo_das_equacoes/models/consts.dart';
import 'package:jogo_das_equacoes/models/player.dart';
import 'package:jogo_das_equacoes/models/sounds.dart';
import 'package:jogo_das_equacoes/providers/player.dart';
import 'package:jogo_das_equacoes/providers/player_status_shared.dart';
import 'package:jogo_das_equacoes/screens/quests_page.dart';
import 'package:provider/provider.dart';

class StagesPage extends StatelessWidget {
  /* @override
  void setState(fn) {
    _initialLoad();
    super.setState(fn);
  }

  void _initialLoad() {
    var playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    var playerStatus = Provider.of<PlayerStatusProviderShared>(
      context,
      listen: false,
    ).getPlayerStatus();
    playerProvider.player.playerStatus = playerStatus;
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Fases'),
        centerTitle: true,
        actions: [
          Score(),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: _getStagesCards(context, NUMBER_OF_STAGES),
      ),

      /* floatingActionButton: Center(
        heightFactor: 5,
        widthFactor: 0.5,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Provider.of<PlayerStatus>(context, listen: false).increaseStage();
          },
        ),
      ), */
    );
  }
}

List<Widget> _getStagesCards(BuildContext context, int numberOfStages) {
  List<Widget> listStages = [];
  double _externalPadding = 16.0;

  for (var i = 0; i < numberOfStages; i++) {
    listStages.add(
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            CustomBoxShadow(),
          ],
        ),
        margin: EdgeInsets.only(
          top: _externalPadding,
          left: _externalPadding,
          bottom: _externalPadding,
          right: i == (numberOfStages - 1) ? _externalPadding : 0,
        ),
        width:
            (MediaQuery.of(context).size.longestSide - _externalPadding * 5) /
                4,
        child: _getStages(context, i),
      ),
    );
  }
  return listStages;
}

Consumer _getStages(BuildContext context, int i) {
  var player = Provider.of<PlayerProvider>(context, listen: false).player;
  if (player != null) {
    return Consumer<PlayerProvider>(
      builder: (context, playerProvider, child) {
        return _StageCard(
          stage: i + 1,
          isEnable: i < playerProvider.player.playerStatus.stage ? true : false,
        );
      },
    );
  } else {
    return Consumer<PlayerStatusProviderShared>(
      builder: (context, playerStatus, child) {
        return _StageCard(
          stage: i + 1,
          isEnable: i < playerStatus.getStage() ? true : false,
        );
      },
    );
  }
}

class _StageCard extends StatelessWidget {
  final int stage;
  final bool isEnable;

  const _StageCard({this.stage, this.isEnable});

  @override
  Widget build(BuildContext context) {
    if (isEnable) {
      return _stageEnable(context, stage);
    } else {
      return _stageDisable(context);
    }
  }

  Widget _stageEnable(BuildContext context, int stage) {
    return Material(
      color: _getColor(context, stage),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          Sounds().clickSound();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => QuestsPage(stage: stage),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$stage',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Schoolbell',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stageDisable(BuildContext context) {
    return Material(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '$stage',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 50,
                fontFamily: 'Schoolbell',
              ),
            ),
            Icon(
              Icons.lock,
              color: Colors.grey[400],
              size: 80,
            ),
          ],
        ),
      ),
    );
  }

  _getColor(BuildContext context, int currentStage) {
    User firebaseUser = context.read<AuthenticationService>().currentUser;
    if (firebaseUser != null) {
      Player _player = Provider.of<PlayerProvider>(
        context,
        listen: false,
      ).player;
      int _quest = _player.playerStatus.quest;
      if (_quest < (NUMBER_OF_QUESTS_IN_EACH_STAGE * currentStage + 1)) {
        return ThemeColors().lightBlue;
      }
      return ThemeColors().blue;
    } else {
      int _quest = Provider.of<PlayerStatusProviderShared>(
        context,
        listen: false,
      ).getQuest();
      if (_quest < (NUMBER_OF_QUESTS_IN_EACH_STAGE * currentStage + 1)) {
        return ThemeColors().lightBlue;
      }
      return ThemeColors().blue;
    }
  }
}
