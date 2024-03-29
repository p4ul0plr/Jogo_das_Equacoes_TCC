import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_scaffold_messenger.dart';
import 'package:jogo_das_equacoes/components/custom_textfild.dart';
import 'package:jogo_das_equacoes/database/authentication_service.dart';
import 'package:jogo_das_equacoes/database/dao/player_dao.dart';
import 'package:jogo_das_equacoes/models/colors.dart';
import 'package:jogo_das_equacoes/models/player.dart';
import 'package:jogo_das_equacoes/providers/player.dart';
import 'package:jogo_das_equacoes/screens/new_account_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoginAlertDialog extends StatefulWidget {
  @override
  _LoginAlertDialogState createState() => _LoginAlertDialogState();
}

class _LoginAlertDialogState extends State<LoginAlertDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _initialLoad();
    super.initState();
  }

  void _initialLoad() async {
    User firebaseUser = context.read<AuthenticationService>().currentUser;
    if (firebaseUser != null) {
      var player = await PlayerDao().read(firebaseUser.uid);
      var playerProvider = Provider.of<PlayerProvider>(context, listen: false);
      playerProvider.signIn(player);
      print(Provider.of<PlayerProvider>(context, listen: false).player);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        scrollable: true,
        title: _showTitle(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        contentPadding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        content: Container(
          width: 350,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _showInputEmail(),
                _showInputPassword(),
                _showmainButton(context),
                _showSecondaryButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _showTitle() {
    return Text(
      'Login',
      style: TextStyle(
        fontSize: 40,
        fontFamily: 'Schoolbell',
      ),
      textAlign: TextAlign.center,
    );
  }

  CustomTextField _showInputPassword() {
    return CustomTextField(
      controlador: _passwordController,
      labelText: 'Senha',
      lengthLimitingTextInputFormatter: 8,
      obscureText: true,
      validator: _validatePassword,
    );
  }

  CustomTextField _showInputEmail() {
    return CustomTextField(
      controlador: _emailController,
      labelText: 'E-mail',
      keyboardType: TextInputType.emailAddress,
      validator: _validateEmail,
    );
  }

  Future<String> _signIn(BuildContext context) async {
    return await context.read<AuthenticationService>().signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }

  void _showSuccessScreen(BuildContext context) {
    customScaffoldMessenger(
      context: context,
      success: true,
      text: 'Login efetuado com sucesso!',
    );
    Navigator.of(context).pop();
    /* Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => NewAccountPage(),
      ),
    ); */
  }

  String _validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Informe o Email";
    } else if (!regExp.hasMatch(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  String _validatePassword(String value) {
    if (value == null || value.isEmpty || value.length < 8) {
      return 'Precisa de 8 dígitos';
    }
    return null;
  }

  void _showErrorMessage({String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            fontFamily: 'Schoolbell',
            fontSize: 16.0,
          ),
        ),
        backgroundColor: ThemeColors().pink,
        duration: Duration(seconds: 5),
      ),
    );
  }

  Widget _showmainButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.0),
      width: 200,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: ThemeColors().pink, // background
          onPrimary: Colors.white, // foreground
        ),
        child: Text('Entrar'),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            String result = await _signIn(context);
            if (result == 'Signed In') {
              User _currentUser =
                  context.read<AuthenticationService>().currentUser;
              Player _newPlayer = await PlayerDao().read(_currentUser.uid);
              Provider.of<PlayerProvider>(context, listen: false)
                  .signIn(_newPlayer);
              _showSuccessScreen(context);
            } else {
              _showErrorMessage(text: result);
            }
          }
        },
      ),
    );
  }

  Widget _showSecondaryButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _calcelButton(context),
        _createAccountButton(context),
      ],
    );
  }

  TextButton _createAccountButton(BuildContext context) {
    return TextButton(
      child: Text(
        'Criar Conta',
        style: TextStyle(
          fontSize: 14.0,
          color: ThemeColors().pink,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => NewAccountPage(),
          ),
        );
      },
    );
  }

  TextButton _calcelButton(BuildContext context) {
    return TextButton(
      child: Text(
        'Cancelar',
        style: TextStyle(
          fontSize: 14.0,
          color: ThemeColors().pink,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
