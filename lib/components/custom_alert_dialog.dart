import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/models/consts.dart';

const String WINNERS_TITLE = 'Parabéns :)';
const String WINNERS_SUBTITLE = 'Você venceu!';
const String LOSERS_TITLE = 'Não foi dessa vez :|';
const String LOSERS_SUBTITLE = 'Você está quase lá, Tente novamente!';

class CustomAlertDialog extends StatelessWidget {
  String _title = '';
  String _subtitle = '';
  IconData _buttonIcon;
  List<Widget> _stars = [];
  final int score;

  CustomAlertDialog({
    this.score = 0,
  }) {
    _getStatusAlertDialog();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text(
          _title,
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'Schoolbell',
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      contentPadding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
      content: Container(
        width: 350,
        child: Column(
          children: [
            Text(
              '$score pontos',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Schoolbell',
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _stars,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                _subtitle,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Schoolbell',
                ),
              ),
            ),
            CustomRoundButton(icon: _buttonIcon)
          ],
        ),
      ),
    );
  }

  void _getStatusAlertDialog() {
    _getStars();
    _getTitlesSubtitlesAndButtons();
  }

  void _getTitlesSubtitlesAndButtons() {
    if (score > 0) {
      _title = WINNERS_TITLE;
      _subtitle = WINNERS_SUBTITLE;
      _buttonIcon = Icons.redo;
    } else {
      _title = LOSERS_TITLE;
      _subtitle = LOSERS_SUBTITLE;
      _buttonIcon = Icons.reply;
    }
  }

  void _getStars() {
    if (score <= MAX_SCORE && score >= MAX_SCORE * 3 ~/ 4) {
      _stars = _getThreeStars;
    } else if (score >= MAX_SCORE * 2 ~/ 4) {
      _stars = _getTwoStars;
    } else if (score >= MAX_SCORE * 1 ~/ 4) {
      _stars = _getOneStars;
    } else if (score > 0) {
      _stars = _getZeroStars;
    } else {
      _stars = _getZeroStars;
    }
  }

  List<Widget> get _getThreeStars {
    return [IconStar(), IconStar(), IconStar()];
  }

  List<Widget> get _getTwoStars {
    return [IconStar(), IconStar(), IconStarWithBorder()];
  }

  List<Widget> get _getOneStars {
    return [IconStar(), IconStarWithBorder(), IconStarWithBorder()];
  }

  List<Widget> get _getZeroStars {
    return [IconStarWithBorder(), IconStarWithBorder(), IconStarWithBorder()];
  }
}

class CustomRoundButton extends StatelessWidget {
  final IconData icon;

  CustomRoundButton({@required this.icon});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Theme.of(context).primaryColor, // button color
        child: InkWell(
          splashColor: Theme.of(context).accentColor, // inkwell color
          child: SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                icon,
                color: Colors.white,
              )),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

class IconStarWithBorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star_border,
      size: 60.0,
      color: Colors.yellow,
    );
  }
}

class IconStar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star,
      size: 60.0,
      color: Colors.yellow,
    );
  }
}
