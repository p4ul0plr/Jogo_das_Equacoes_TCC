import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo_das_equacoes/components/button_with_text_outside.dart';
import 'package:jogo_das_equacoes/screens/credits_page.dart';
import 'package:jogo_das_equacoes/screens/help_page.dart';
import 'package:jogo_das_equacoes/screens/login_page.dart';
import 'package:jogo_das_equacoes/screens/podium_page.dart';
import 'package:jogo_das_equacoes/screens/stages_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _showTheApplicationTitle(),
            Spacer(),
            _showMainButtons(context),
            Spacer(),
            _showSecondaryButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _showTheApplicationTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Jogo das Equações',
          style: TextStyle(
            fontSize: 60,
            fontFamily: 'Schoolbell',
          ),
        ),
      ],
    );
  }

  Widget _showMainButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _podiumButton(context),
        _playButton(context),
      ],
    );
  }

  Widget _podiumButton(BuildContext context) {
    return ButtonWithTextOutside(
      textPosition: ButtonWithTextOutsidePosition.left,
      title: 'Pódio',
      icon: Icons.format_list_numbered,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PodiumPage(),
          ),
        );
      },
    );
  }

  Widget _playButton(BuildContext context) {
    return ButtonWithTextOutside(
        textPosition: ButtonWithTextOutsidePosition.right,
        title: 'Jogar',
        icon: Icons.play_arrow_rounded,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => StagesPage(),
            ),
          );
        });
  }
}

Widget _showSecondaryButtons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      _exitButton(),
      Row(
        children: [
          _helpButton(context),
          _accountButton(context),
        ],
      ),
      _creditsButton(context),
    ],
  );
}

Widget _helpButton(BuildContext context) {
  return ButtonWithTextOutside(
    textPosition: ButtonWithTextOutsidePosition.bottom,
    title: 'Ajuda',
    icon: Icons.help,
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HelpPage(),
        ),
      );
    },
  );
}

Widget _accountButton(BuildContext context) {
  return ButtonWithTextOutside(
    textPosition: ButtonWithTextOutsidePosition.bottom,
    title: 'Conta',
    icon: Icons.account_circle_rounded,
    onPressed: () {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return LoginPage();
        },
      );
    },
  );
}

Widget _exitButton() {
  return ButtonWithTextOutside(
    textPosition: ButtonWithTextOutsidePosition.top,
    title: 'Sair',
    icon: Icons.exit_to_app_rounded,
    onPressed: () => SystemNavigator.pop(),
  );
}

Widget _creditsButton(BuildContext context) {
  return ButtonWithTextOutside(
    textPosition: ButtonWithTextOutsidePosition.top,
    title: 'Créditos',
    icon: Icons.feedback,
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Credits(row: 4, column: 7),
        ),
      );
    },
  );
}
