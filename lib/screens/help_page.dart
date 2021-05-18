import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_card.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/components/info_card.dart';
import 'package:jogo_das_equacoes/models/colors.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Ajuda'),
        backgroundColor: ThemeColors().pink,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              _titleCard(),
              _stagesCard(),
              _questsCard(),
              _gameMatchCard(),
              _winCard(),
              _loseCard(),
              _podiumCard(),
              _accountCard(),
              _loginCard(),
            ],
          ),
        ),
      ),
    );
  }

  CustomCard _titleCard() {
    return CustomCard(
      color: ThemeColors().lightPink,
      child: Text(
        'O “Jogo das Equações”, é um jogo que auxilia no processo de aprendizagem de equações do 1º grau',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Schoolbell',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  InfoCard _stagesCard() {
    return InfoCard(
      color: ThemeColors().lightPink,
      text: ['O jogo contém 4 fases com níveis de dificuldade diferente.'],
      imagePath: 'assets/images/screens/stages.jpg',
      infoCardPosition: InfoCardPosition.textLeftImageRight,
    );
  }

  InfoCard _questsCard() {
    return InfoCard(
      color: ThemeColors().lightPink,
      text: [
        'Cada fase contém 10 missões diferentes.',
        'A cada missão concluida, a seguinte será desbloqueada.',
      ],
      imagePath: 'assets/images/screens/quests.jpg',
      infoCardPosition: InfoCardPosition.textRightImageLeft,
    );
  }

  InfoCard _gameMatchCard() {
    return InfoCard(
      color: ThemeColors().lightPink,
      text: [
        'A cada missão você receberá uma equação diferente para resolver.',
        'Você terá 60 segundos para escolher a resposta correta.',
        'Você terá 3 chances para acertar a resposta dentre as alternativas.',
      ],
      imagePath: 'assets/images/screens/quests/quest-38.jpg',
      infoCardPosition: InfoCardPosition.textLeftImageRight,
    );
  }

  InfoCard _winCard() {
    return InfoCard(
      color: ThemeColors().lightPink,
      text: [
        'A cada missão concluída, você receberá uma pontuação condizente com o seu desempenho.',
        'Essa pontuação será incrementada e formará a sua pontuação total.',
      ],
      imagePath: 'assets/images/screens/success.jpg',
      infoCardPosition: InfoCardPosition.textRightImageLeft,
    );
  }

  InfoCard _loseCard() {
    return InfoCard(
      color: ThemeColors().lightPink,
      text: [
        'Mas se você não conseguir passar na missão não se preocupe, você pode reiniciar a missão e tentar quantas vezes quiser.'
      ],
      imagePath: 'assets/images/screens/failure.jpg',
      infoCardPosition: InfoCardPosition.textLeftImageRight,
    );
  }

  InfoCard _podiumCard() {
    return InfoCard(
      color: ThemeColors().lightPink,
      text: [
        'A pontuação adquirida durante o jogo será usada para a construção do pódio onde você poderá comparar a sua pontuação com os colegas e amigos.',
      ],
      imagePath: 'assets/images/screens/podium.jpg',
      infoCardPosition: InfoCardPosition.textRightImageLeft,
    );
  }

  InfoCard _loginCard() {
    return InfoCard(
      color: ThemeColors().lightPink,
      text: [
        'Depois de ter a sua conta criada basta efetuar o login. Com o login feito é possível acessar o pódio e competir com seus amigos.',
        'Para logar com sua conta é necessário acesso a internet.',
      ],
      imagePath: 'assets/images/screens/login.jpg',
      infoCardPosition: InfoCardPosition.textRightImageLeft,
    );
  }

  InfoCard _accountCard() {
    return InfoCard(
      color: ThemeColors().lightPink,
      text: [
        'Para participar do pódio é necessário acesso a internet e a criação da conta com as informações do usuário.',
      ],
      imagePath: 'assets/images/screens/account.jpg',
      infoCardPosition: InfoCardPosition.textLeftImageRight,
    );
  }
}
