import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_card.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/components/info_card.dart';
import 'package:jogo_das_equacoes/models/colors.dart';

class StageHelp extends StatelessWidget {
  final int stage;

  StageHelp({@required this.stage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Fase $stage: Ajuda'),
        backgroundColor: ThemeColors().blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: _getStageHelp(),
        ),
      ),
    );
  }

  Widget _getStageHelp() {
    switch (stage) {
      case 1:
        return _stage1Help();
        break;
      case 2:
        return _stage2Help();
        break;
      case 3:
        return _stage3Help();
        break;
      case 4:
        return _stage4Help();
        break;
      default:
        return null;
    }
  }

  Widget _stage1Help() {
    return Column(
      children: [
        CustomCard(
          color: ThemeColors().lightBlue,
          child: Text(
            'A fase 1 do “Jogo das Equações” apresenta equações do 1º grau com elementos de soma e subtração',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Schoolbell',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        CustomCard(
          color: ThemeColors().lightBlue,
          child: Text(
            'Para uma equação do 1º grau, deve-se achar o valor da incógnita (que aqui é representado por frutas) e, para que isso seja possível, é só isolar o valor da incógnita na igualdade, ou seja, a incógnita (a fruta) deve ficar sozinho em um dos membros da equação.',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'Schoolbell',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        CustomCard(
          color: ThemeColors().lightBlue,
          child: Text(
            'O próximo passo é analisar qual operação está sendo feita no mesmo membro em que se encontra a fruta e “jogar” para o outro lado da igualdade fazendo a operação oposta e isolando a fruta.',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'Schoolbell',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        InfoCard(
          color: ThemeColors().lightBlue,
          text: [
            'Nesse caso, o número que aparece do mesmo lado da fruta é o 10 e ele está somando. Para isolar a fruta, ele vai para o outro lado da igualdade fazendo a operação inversa (subtração):\nx = 6 - 10\nx = -4',
          ],
          imagePath: 'assets/images/screens/quests/quest-1.jpg',
          infoCardPosition: InfoCardPosition.textRightImageLeft,
        ),
        InfoCard(
          color: ThemeColors().lightBlue,
          text: [
            'Nesse caso, o número que aparece do mesmo lado da fruta é o -3 e ele está subtraindo. Para isolar a fruta, ele vai para o outro lado da igualdade fazendo a operação inversa (soma):\nx = 7 + 3\nx = 10',
          ],
          imagePath: 'assets/images/screens/quests/quest-4.jpg',
          infoCardPosition: InfoCardPosition.textLeftImageRight,
        ),
        InfoCard(
          color: ThemeColors().lightBlue,
          text: [
            'Nesse caso, o número que aparece do mesmo lado da fruta é o 10 e ele está somando. Para isolar a fruta, ele vai para o outro lado da igualdade fazendo a operação inversa (subtração):\nx = -4 - 10\nx = -14',
          ],
          imagePath: 'assets/images/screens/quests/quest-8.jpg',
          infoCardPosition: InfoCardPosition.textRightImageLeft,
        ),
      ],
    );
  }

  Widget _stage2Help() {
    return Column(
      children: [
        CustomCard(
          color: ThemeColors().lightBlue,
          child: Text(
            'A fase 2 do “Jogo das Equações” apresenta equações do 1º grau com elementos de soma, subtração e multiplicação',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Schoolbell',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        CustomCard(
          color: ThemeColors().lightBlue,
          child: Text(
            'Para uma equação do 1º grau, deve-se achar o valor da incógnita (que aqui é representado por frutas) e, para que isso seja possível, é só isolar o valor da incógnita na igualdade, ou seja, a incógnita (a fruta) deve ficar sozinho em um dos membros da equação.',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'Schoolbell',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        CustomCard(
          color: ThemeColors().lightBlue,
          child: Text(
            'O próximo passo é analisar qual operação está sendo feita no mesmo membro em que se encontra a fruta e “jogar” para o outro lado da igualdade fazendo a operação oposta e isolando a fruta.',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'Schoolbell',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        InfoCard(
          color: ThemeColors().lightBlue,
          text: [
            'Vamos analisar os números que estão no mesmo lado da fruta, o 2 e o 10. O número 10 está somando e vai para o outro lado da igualdade subtraindo, e o número 2 que está multiplicando, passa para o outro lado dividindo.\nx = (2 - 10)/2\nx = -8/2\nx = -4',
          ],
          imagePath: 'assets/images/screens/quests/quest-11.jpg',
          infoCardPosition: InfoCardPosition.textRightImageLeft,
        ),
        InfoCard(
          color: ThemeColors().lightBlue,
          text: [
            'Vamos analisar os números que estão no mesmo lado da fruta, o 3 e o -10. O número -10 está subtraindo e vai para o outro lado da igualdade somando, e o número 3 que está multiplicando, passa para o outro lado dividindo.\nx = (8 + 10)/3\nx = 18/3\nx = 6',
          ],
          imagePath: 'assets/images/screens/quests/quest-14.jpg',
          infoCardPosition: InfoCardPosition.textLeftImageRight,
        ),
        InfoCard(
          color: ThemeColors().lightBlue,
          text: [
            'Vamos analisar os números que estão no mesmo lado da fruta, o -2 e o -4. O número -4 está subtraindo e vai para o outro lado da igualdade somando, e o número -2 que está multiplicando, passa para o outro lado dividindo.\nx = (4 + 4)/(-2)\nx = 8/(-2)\nx = -4',
          ],
          imagePath: 'assets/images/screens/quests/quest-18.jpg',
          infoCardPosition: InfoCardPosition.textRightImageLeft,
        ),
      ],
    );
  }

  Widget _stage3Help() {
    return Column(
      children: [
        CustomCard(
          color: ThemeColors().lightBlue,
          child: Text(
            'A fase 3 do “Jogo das Equações” apresenta equações do 1º grau com elementos de soma, subtração e divisão',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Schoolbell',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        CustomCard(
          color: ThemeColors().lightBlue,
          child: Text(
            'Para uma equação do 1º grau, deve-se achar o valor da incógnita (que aqui é representado por frutas) e, para que isso seja possível, é só isolar o valor da incógnita na igualdade, ou seja, a incógnita (a fruta) deve ficar sozinho em um dos membros da equação.',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'Schoolbell',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        CustomCard(
          color: ThemeColors().lightBlue,
          child: Text(
            'O próximo passo é analisar qual operação está sendo feita no mesmo membro em que se encontra a fruta e “jogar” para o outro lado da igualdade fazendo a operação oposta e isolando a fruta.',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'Schoolbell',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        InfoCard(
          color: ThemeColors().lightBlue,
          text: [
            'Vamos analisar os números que estão no mesmo lado da fruta, o 4 e o 2. O número 2 está somando e vai para o outro lado da igualdade subtraindo, e o número 4 que está dividindo, passa para o outro lado multiplicando.\nx = 4 · (3 - 2)\nx = 4 · 1\nx = 4',
          ],
          imagePath: 'assets/images/screens/quests/quest-21.jpg',
          infoCardPosition: InfoCardPosition.textRightImageLeft,
        ),
        InfoCard(
          color: ThemeColors().lightBlue,
          text: [
            'Vamos analisar os números que estão no mesmo lado da fruta, o 2 e o -2. O número -2 está subtraindo e vai para o outro lado da igualdade somando, e o número 2 que está dividindo, passa para o outro lado multiplicando.\nx = 2 · (4 + 2)\nx = 2 · 6\nx = 12',
          ],
          imagePath: 'assets/images/screens/quests/quest-24.jpg',
          infoCardPosition: InfoCardPosition.textLeftImageRight,
        ),
        InfoCard(
          color: ThemeColors().lightBlue,
          text: [
            'Vamos analisar os números que estão no mesmo lado da fruta, o -3 e o -5. O número -5 está subtraindo e vai para o outro lado da igualdade sumando, e o número -3 que está dividindo, passa para o outro lado multiplicando.\nx = -3 · (-2 + 5)\nx = -3 · 3\nx = -9',
          ],
          imagePath: 'assets/images/screens/quests/quest-28.jpg',
          infoCardPosition: InfoCardPosition.textRightImageLeft,
        ),
      ],
    );
  }

  Widget _stage4Help() {
    return Column(
      children: [
        CustomCard(
          color: ThemeColors().lightBlue,
          child: Text(
            'A fase 4 do “Jogo das Equações” apresenta equações do 1º grau com duas incógnitas com elementos de soma e subtração',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Schoolbell',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        CustomCard(
          color: ThemeColors().lightBlue,
          child: Text(
            'Para uma equação do 1º grau com duas incógnitas apresentadas aqui, deve-se substituir o valor da incógnita (que aqui é representado por frutas) que aparece sozinha na segunda equação que apresenta duas frutas',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'Schoolbell',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        CustomCard(
          color: ThemeColors().lightBlue,
          child: Text(
            'O próximo passo é analisar qual operação está sendo feita no mesmo membro em que se encontra a fruta e “jogar” para o outro lado da igualdade fazendo a operação oposta e isolando a fruta.',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'Schoolbell',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        InfoCard(
          color: ThemeColors().lightBlue,
          text: [
            'Vamos analisar as equações. A primeira nos diz que y = 5, dessa forma basta substituir o valor de y na segunda equação, e isolar o x.\ny = 5\nx + 5 = 6\nx = 6 - 5\nx = 1',
          ],
          imagePath: 'assets/images/screens/quests/quest-31.jpg',
          infoCardPosition: InfoCardPosition.textRightImageLeft,
        ),
        InfoCard(
          color: ThemeColors().lightBlue,
          text: [
            'Vamos analisar as equações. A primeira nos diz que y = 8, dessa forma basta substituir o valor de y na segunda equação, e isolar o x.\ny = 8\nx - 8 = 10\nx = 10 + 8\nx = 18',
          ],
          imagePath: 'assets/images/screens/quests/quest-34.jpg',
          infoCardPosition: InfoCardPosition.textLeftImageRight,
        ),
        InfoCard(
          color: ThemeColors().lightBlue,
          text: [
            'Vamos analisar as equações. A primeira nos diz que y = -4, dessa forma basta substituir o valor de y na segunda equação, e isolar o x.\ny = -4\nx - (-4) = 1\nx + 4 = 1\nx = 1 - 4\nx = -3',
          ],
          imagePath: 'assets/images/screens/quests/quest-38.jpg',
          infoCardPosition: InfoCardPosition.textRightImageLeft,
        ),
      ],
    );
  }
}
