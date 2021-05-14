import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/models/colors.dart';

class StageHelp extends StatelessWidget {
  final int stage;

  StageHelp({@required this.stage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Fase $stage: Ajuda'),
        backgroundColor: ThemeColors().pink,
        centerTitle: true,
      ),
    );
  }
}
