import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/models/colors.dart';

const String mainText =
    'Trabalho apresentado à Universidade Federal do Vale do São Francisco - UNIVASF, Campus Juazeiro, como requisito para obtenção do título de Bacharel em Engenharia da Computação.';
const String secondaryText =
    'Aluno: Paulo Roberto da Silva Nobrega \nOrientador: Prof. Dr. Ricardo Argenton Ramos\n Co-orientadores: Prof. Michel Ferreira Batista e \nKeren Priscila da Silva Nobrega';

class Credits extends StatelessWidget {
  final int row;
  final int column;

  Credits({this.row, this.column});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Crétitos'),
        backgroundColor: ThemeColors().green,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo_univasf.png',
                  height: 70,
                ),
                SizedBox(height: 25.0),
                Container(
                  width: 600,
                  child: Text(
                    mainText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                Container(
                  width: 600,
                  child: Text(
                    secondaryText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
