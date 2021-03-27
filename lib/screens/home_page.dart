import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo_das_equacoes/screens/credits_page.dart';
import 'package:jogo_das_equacoes/screens/help_page.dart';
import 'package:jogo_das_equacoes/screens/login_page.dart';
import 'package:jogo_das_equacoes/screens/podium_page.dart';
import 'package:jogo_das_equacoes/screens/stages_page.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
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
            //Título da Aplicação
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Jogo das Equações',
                  style: TextStyle(
                    fontSize: 70,
                    fontFamily: 'Schoolbell',
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //texto Pódio
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    'Pódio',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Schoolbell',
                    ),
                  ),
                ),
                //Botão Pódio
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.format_list_numbered),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PodiumPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                //Botão Jogar
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.play_arrow_rounded),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StagesPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                //Botão Jogar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Jogar',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Schoolbell',
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    //Texto Sair
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Sair',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Schoolbell',
                        ),
                      ),
                    ),
                    //Botão Sair
                    Ink(
                      decoration: ShapeDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.exit_to_app_rounded),
                        color: Colors.white,
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        //Botão Ajuda
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Ink(
                            decoration: ShapeDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.help),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => HelpPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        //Text Ajuda
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Ajuda',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Schoolbell',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        //Botão Conta
                        Ink(
                          decoration: ShapeDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.account_circle_rounded),
                            color: Colors.white,
                            onPressed: () {
                              showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) {
                                  return LoginPage();
                                },
                              );
                            },
                          ),
                        ),
                        //Texto Conta
                        Text(
                          'Conta',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Schoolbell',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    //Texto Créditos
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Créditos',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Schoolbell',
                        ),
                      ),
                    ),
                    //Botão Créditos
                    Ink(
                      decoration: ShapeDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.feedback),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Credits(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
