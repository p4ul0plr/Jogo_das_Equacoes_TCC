import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo_das_equacoes/components/button_with_text_outside.dart';
import 'package:jogo_das_equacoes/models/colors.dart';
import 'package:jogo_das_equacoes/models/sounds.dart';
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
      body: Container(
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/blackboard4.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _showTheApplicationTitle(),
            _showMainButtons(context),
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
            color: Colors.white.withOpacity(0.8),
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
      color: ThemeColors().blue,
      onPressed: () {
        Sounds().clickSound();
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
        color: ThemeColors().blue,
        onPressed: () {
          Sounds().clickSound();
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
    color: ThemeColors().pink,
    onPressed: () {
      Sounds().clickSound();
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
    color: ThemeColors().pink,
    onPressed: () {
      Sounds().clickSound();
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
    color: ThemeColors().green,
    onPressed: () {
      Sounds().clickSound();
      SystemNavigator.pop();
    },
  );
}

Widget _creditsButton(BuildContext context) {
  return ButtonWithTextOutside(
    textPosition: ButtonWithTextOutsidePosition.top,
    title: 'Créditos',
    icon: Icons.feedback,
    color: ThemeColors().green,
    onPressed: () {
      Sounds().clickSound();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Credits(row: 4, column: 7),
        ),
      );
    },
  );
}
