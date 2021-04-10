import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/screens/quests_page.dart';

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
          child: Icon(Icons.arrow_forward),
          onPressed: () {},
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
            right: i == (numberOfStages - 1) ? 32.0 : 0),
        width: (MediaQuery.of(context).size.longestSide - 32 * 5) / 4,
        child: Material(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => QuestsPage(stage: i + 1),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Schoolbell',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  return listStages;
}
