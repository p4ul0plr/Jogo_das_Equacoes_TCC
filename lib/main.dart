import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo_das_equacoes/database/authentication_service.dart';
import 'package:jogo_das_equacoes/models/colors.dart';
import 'package:jogo_das_equacoes/models/player_status.dart';
import 'package:jogo_das_equacoes/providers/game_match.dart';
import 'package:jogo_das_equacoes/providers/player.dart';
import 'package:jogo_das_equacoes/providers/player_status.dart';
import 'package:jogo_das_equacoes/screens/authentication_wrapper.dart';
import 'package:jogo_das_equacoes/screens/home_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Esconder a barra de navegação e a StatusBar
  SystemChrome.setEnabledSystemUIOverlays([]);
  //Esconder a barra de navegação
  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  //Esconder StatusBar
  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  //Colocar o celular em landscape
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]).then(
    (value) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => PlayerStatus(),
          ),
          ChangeNotifierProvider(
            create: (context) => PlayerStatusProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => GameMatchProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PlayerProvider(),
          ),
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null,
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
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
        primaryColor: ThemeColors().blue,
        accentColor: ThemeColors().lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Theme.of(context).textTheme,
        /* primaryTextTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 40,
            fontFamily: 'Schoolbell',
          ),
        ), */
      ),
      home: HomePage(),
    );
  }
}
