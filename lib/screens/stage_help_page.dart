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
            'A fase 1 do “Jogo das Equações”, apresenta equações do 1º grau com elementos de soma e subtração',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Schoolbell',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        InfoCard(
          color: ThemeColors().lightBlue,
          text: [
            'A pontuação adquirida durante o jogo será usada para a construção do pódio onde você poderá comparar a sua pontuação com os colegas e amigos.',
            'Para participar do pódio é necessário acesso a internet e a criação da conta com as informações do usuário.'
          ],
          imagePath: 'assets/images/screens/podium.jpg',
          infoCardPosition: InfoCardPosition.textRightImageLeft,
        ),
        InfoCard(
          color: ThemeColors().lightBlue,
          text: [
            'A pontuação adquirida durante o jogo será usada para a construção do pódio onde você poderá comparar a sua pontuação com os colegas e amigos.',
            'Para participar do pódio é necessário acesso a internet e a criação da conta com as informações do usuário.'
          ],
          imagePath: 'assets/images/screens/podium.jpg',
          infoCardPosition: InfoCardPosition.textLeftImageRight,
        ),
      ],
    );
  }

  Widget _stage2Help() {
    return Center(
      child: Text(
        stage.toString(),
      ),
    );
  }

  Widget _stage3Help() {
    return Center(
      child: Text(
        stage.toString(),
      ),
    );
  }

  Widget _stage4Help() {
    return Center(
      child: Text(
        stage.toString(),
      ),
    );
  }
}
