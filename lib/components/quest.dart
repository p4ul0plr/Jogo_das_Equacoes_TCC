import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_boxshadow.dart';
import 'package:jogo_das_equacoes/database/authentication_service.dart';
import 'package:jogo_das_equacoes/models/colors.dart';
import 'package:jogo_das_equacoes/models/consts.dart';
import 'package:jogo_das_equacoes/models/player.dart';
import 'package:jogo_das_equacoes/models/sounds.dart';
import 'package:jogo_das_equacoes/providers/player.dart';
import 'package:jogo_das_equacoes/providers/player_status_shared.dart';
import 'package:jogo_das_equacoes/screens/game_match_page.dart';
import 'package:provider/provider.dart';

class Quest extends StatelessWidget {
  final int quest;
  final double width;
  final double height;
  final bool isEnable;
  final int currentStage;

  Quest({
    this.quest,
    this.width,
    this.height,
    this.isEnable,
    this.currentStage,
  });

  @override
  Widget build(BuildContext context) {
    if (isEnable) {
      return Container(
        margin: EdgeInsets.all(8.0),
        width: width,
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            CustomBoxShadow(),
          ],
        ),
        child: Material(
          color: _getColor(context),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () {
              Sounds().clickSound();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GameMatchPage(
                    quest: quest.toString(),
                    currentStage: currentStage,
                  ),
                ),
              );
            },
            child: Center(
              child: Text(
                quest.toString(),
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Schoolbell',
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(8.0),
        width: width,
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            CustomBoxShadow(),
          ],
        ),
        child: Material(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  quest.toString(),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 30,
                    fontFamily: 'Schoolbell',
                  ),
                ),
                Icon(
                  Icons.lock,
                  color: Colors.grey[400],
                  size: 50,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  _getColor(BuildContext context) {
    User firebaseUser = context.read<AuthenticationService>().currentUser;
    if (firebaseUser != null) {
      Player _player = Provider.of<PlayerProvider>(
        context,
        listen: false,
      ).player;
      int _quest = _player.playerStatus.quest;
      if (quest < _quest ||
          _quest == (NUMBER_OF_QUESTS_IN_EACH_STAGE * NUMBER_OF_STAGES + 1)) {
        return ThemeColors().blue;
      }
      return ThemeColors().lightBlue;
    } else {
      int _quest = Provider.of<PlayerStatusProviderShared>(
        context,
        listen: false,
      ).getQuest();
      if (quest < _quest ||
          _quest == (NUMBER_OF_QUESTS_IN_EACH_STAGE * NUMBER_OF_STAGES + 1)) {
        return ThemeColors().blue;
      }
      return ThemeColors().lightBlue;
    }
  }
}
