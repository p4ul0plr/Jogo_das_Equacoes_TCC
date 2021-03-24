import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo_das_equacoes/components/form_account_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Esconder a barra de navegação e a StatusBar
  SystemChrome.setEnabledSystemUIOverlays([]);
  //Esconder a barra de navegação
  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  //Esconder StatusBar
  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  //Colocar o celular em landscape
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((value) => runApp(MyApp()));
  //Trazer StatusBar de volta
  // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  //StatusBar transparente
  /* SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  )); */
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        /* primaryTextTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 40,
            fontFamily: 'Schoolbell',
          ),
        ), */
      ),
      home: FormAccountPage(),
    );
  }
}
