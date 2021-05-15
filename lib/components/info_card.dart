import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_card.dart';

enum InfoCardPosition {
  textLeftImageRight,
  textRightImageLeft,
}

class InfoCard extends StatelessWidget {
  final Color color;
  final List<String> text;
  final String imagePath;
  final InfoCardPosition infoCardPosition;

  InfoCard({
    @required this.color,
    @required this.text,
    @required this.imagePath,
    @required this.infoCardPosition,
  });

  @override
  Widget build(BuildContext context) {
    switch (infoCardPosition) {
      case InfoCardPosition.textLeftImageRight:
        return _textLeftImageRight();
        break;
      case InfoCardPosition.textRightImageLeft:
        return _textRightImageLeft();
        break;
      default:
        return null;
    }
  }

  CustomCard _textLeftImageRight() {
    return CustomCard(
      color: color,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                children: _getTextWidgets(),
              ),
            ),
          ),
          Expanded(
            child: Image.asset(imagePath),
          ),
        ],
      ),
    );
  }

  CustomCard _textRightImageLeft() {
    return CustomCard(
      color: color,
      child: Row(
        children: [
          Expanded(
            child: Image.asset(imagePath),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                children: _getTextWidgets(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getTextWidgets() {
    List<Widget> _textList = [];
    text.forEach((element) {
      _textList.add(
        CustomText(
          text: element,
        ),
      );
    });
    return _textList;
  }
}
