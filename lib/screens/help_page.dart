import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(
          title: 'Ajuda',
        ),
      ),
    );
  }
}
