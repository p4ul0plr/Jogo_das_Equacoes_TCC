import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';

class Credits extends StatelessWidget {
  final int row;
  final int column;

  Credits({this.row, this.column});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemHeight = (size.shortestSide - kToolbarHeight) / row;
    final itemWidth = (size.longestSide) / column;
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(
          title: 'Crétitos',
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: GridView.count(
                childAspectRatio: (itemHeight / itemWidth),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(0.0),
                crossAxisCount: row,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                shrinkWrap: true,
                children: _getItens(row * column)),
          ),
          Expanded(
            flex: 1,
            child: Text(''),
          )
        ],
      ),
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
        child: Center(child: CustomTitle(title: '${i + 1}')),
      ),
    );
  }
  return listItens;
}
