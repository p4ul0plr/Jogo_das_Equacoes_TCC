import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';

class Credits extends StatelessWidget {
  final int row;
  final int column;

  Credits({this.row, this.column});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemHeight = (size.shortestSide - kToolbarHeight - 32 * 2);
    final itemWidth = (size.longestSide - 32 * 5) / 4;
    print(kToolbarHeight);
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(
          title: 'Crétitos',
        ),
      ),
      body: GridView.count(
          childAspectRatio: (itemHeight / itemWidth),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(32.0),
          crossAxisCount: 2,
          crossAxisSpacing: 32,
          mainAxisSpacing: 32,
          shrinkWrap: true,
          children: _getItens(20)),
    );
  }
}

List<Widget> _getItens(int quantity) {
  List listItens = List<Widget>();
  for (var i = 0; i < quantity; i++) {
    listItens.add(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue[100],
          /* boxShadow: [
                BoxShadow(color: Colors.grey[200], spreadRadius: 5),
              ], */
        ),
        child: Center(child: CustomTitle(title: 'Teste ${i + 1}')),
      ),
    );
  }
  return listItens;
}
