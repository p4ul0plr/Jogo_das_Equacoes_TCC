import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/models/consts.dart';
import 'package:jogo_das_equacoes/models/randon_numbers.dart';

class EquationWidget extends StatelessWidget {
  final List equations;

  EquationWidget({@required this.equations});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _getEquation(equations),
      ),
    );
  }

  List<Widget> _getEquation(List equations) {
    double _widgetSize = 70.0;
    List<Widget> _equationsList;
    List<Widget> _rowsEquationList = [];
    String _imageFruit = _getRandonFruit();
    for (var i = 0; i < equations.length; i++) {
      _equationsList = [];
      for (var j = 0; j < equations[i].length; j++) {
        if (!UNKNOWN.contains(equations[i][j])) {
          _equationsList.add(
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  equations[i][j],
                  style: TextStyle(
                    fontSize: _widgetSize,
                    fontFamily: 'Schoolbell',
                  ),
                ),
              ),
            ),
          );
        } else {
          _equationsList.add(
            Expanded(
              flex: 1,
              child: Center(
                child: Image.asset(
                  _imageFruit,
                  height: _widgetSize,
                ),
              ),
            ),
          );
        }
      }
      _rowsEquationList.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _equationsList,
        ),
      );
    }
    return _rowsEquationList;
  }

  String _getRandonFruit() {
    int _number = RandonNumbers().generatePositiveRandomNumber(max: 3);
    switch (_number) {
      case 1:
        return 'assets/images/fruits/maca.png';
        break;
      case 2:
        return 'assets/images/fruits/laranja.png';
        break;
      case 3:
        return 'assets/images/fruits/banana-1.png';
        break;
      default:
        return null;
    }
  }
}
