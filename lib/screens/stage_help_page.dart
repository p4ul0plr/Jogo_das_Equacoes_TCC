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
      body: _getStageHelp(),
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

  Widget _stage1Help() {}

  Widget _stage2Help() {}

  Widget _stage3Help() {}

  Widget _stage4Help() {}
}
