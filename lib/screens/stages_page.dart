import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/models/player_status.dart';
import 'package:jogo_das_equacoes/providers/player_status.dart';
import 'package:jogo_das_equacoes/screens/quests_page.dart';
import 'package:provider/provider.dart';

class StagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Fases'),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: _getStages(context, 4),
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

List<Widget> _getStages(BuildContext context, int numberOfStages) {
  List<Widget> listStages = [];

  for (var i = 0; i < numberOfStages; i++) {
    listStages.add(
      Container(
          margin: EdgeInsets.only(
            top: 32.0,
            left: 32.0,
            bottom: 32.0,
            right: i == (numberOfStages - 1) ? 32.0 : 0,
          ),
          width: (MediaQuery.of(context).size.longestSide - 32 * 5) / 4,
          child: Consumer<PlayerStatusProvider>(
            builder: (context, playerStatus, child) {
              return _StageCard(
                title: i + 1,
                isEnable: i < playerStatus.getStage() ? true : false,
              );
            },
          )),
    );
  }
  return listStages;
}

class _StageCard extends StatelessWidget {
  final int title;
  final bool isEnable;

  const _StageCard({this.title, this.isEnable});

  @override
  Widget build(BuildContext context) {
    if (isEnable) {
      return _stageEnable(context);
    } else {
      return _stageDisable(context);
    }
  }

  Widget _stageEnable(BuildContext context) {
    return Material(
      color: Theme.of(context).accentColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => QuestsPage(stage: title),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$title',
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
              '$title',
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
}
