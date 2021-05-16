import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_textfild.dart';
import 'package:jogo_das_equacoes/database/authentication_service.dart';
import 'package:jogo_das_equacoes/models/colors.dart';
import 'package:jogo_das_equacoes/models/player.dart';
import 'package:jogo_das_equacoes/screens/new_account_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'Schoolbell',
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        contentPadding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
        content: Container(
          width: 350,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CustomTextField(
                  controlador: _emailController,
                  labelText: 'E-mail',
                  validator: _validateEmail,
                ),
                CustomTextField(
                  controlador: _passwordController,
                  labelText: 'Senha',
                  lengthLimitingTextInputFormatter: 8,
                  obscureText: true,
                  validator: _validatePassword,
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
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
                        String result =
                            await context.read<AuthenticationService>().signIn(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );
                        if (result == 'Signed In') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NewAccountPage(),
                            ),
                          );
                        }
                        /* Player user = new Player(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('$user'),
                            );
                          },
                        ); */

                        /* await _register();
                        print(_success == null
                            ? ''
                            : (_success
                                ? 'Successfully registered $_userEmail'
                                : 'Registration failed')); */
                        /* try {
                          await Firebase.initializeApp();
                          UserCredential firebaseUser = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          print(firebaseUser);
                        } on Exception catch (e) {
                          print('Error: $e');
                        } */
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: ThemeColors().pink,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text(
                        'Criar Conta',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: ThemeColors().pink,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NewAccountPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

/*   Future<void> _register() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      _success = false;
    }
  } */

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
}
