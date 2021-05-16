import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_card.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/models/colors.dart';

class PodiumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Pódio'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _firstPlaced(),
          _lastPlaced(),
        ],
      ),
    );
  }

  Widget _firstPlaced() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(top: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: CustomCard(
                color: ThemeColors().blue,
                child: Text(
                  '2º Lugar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Schoolbell',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: CustomCard(
                color: ThemeColors().yellow,
                child: Text(
                  '1º\nLugar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Schoolbell',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
            ),
            Expanded(
              child: CustomCard(
                color: ThemeColors().green,
                child: Text(
                  '3º Lugar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Schoolbell',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lastPlaced() {
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
