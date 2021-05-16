import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_dropdownbuttom.dart';
import 'package:jogo_das_equacoes/components/custom_textfild.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/database/authentication_service.dart';
import 'package:jogo_das_equacoes/database/dao/player_dao.dart';
import 'package:jogo_das_equacoes/models/colors.dart';
import 'package:jogo_das_equacoes/models/player.dart';
import 'package:jogo_das_equacoes/providers/player.dart';
import 'package:provider/provider.dart';

const List<String> grades = [
  '1º ano',
  '2º ano',
  '3º ano',
  '4º ano',
  '5º ano',
  '6º ano',
  '7º ano',
  '8º ano',
  '9º ano'
];
const List<String> schools = [
  'CEMAS - Colégio Estadual Misael Aguilar Silva',
  'Colégio Estadual Antonilio Da Franca Cardoso',
];
const List<String> gender = ['Masculino', 'Feminino', 'Outro'];

class NewAccountPage extends StatefulWidget {
  @override
  _NewAccountPageState createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _selectedSchool;
  String _selectedGrade;
  String _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(title: 'Conta'),
        backgroundColor: ThemeColors().pink,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                // Process data.
                dynamic _result =
                    await context.read<AuthenticationService>().register(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                await context.read<AuthenticationService>().signIn(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                try {
                  Player user = Player(
                    id: _result.uid,
                    name: _nameController.text,
                    gender: _selectedGender,
                    email: _emailController.text,
                    password: _passwordController.text,
                    grade: _selectedGrade,
                    school: _selectedSchool,
                    /* playerStatus: new PlayerStatus(), */
                  );
                  print(user);
                  final PlayerDao _playerDao = PlayerDao();
                  _playerDao.create(user);
                  _showSnackBar(
                    context: context,
                    text: 'Conta criada com sucesso!',
                    success: true,
                  );
                } catch (e) {
                  _showSnackBar(
                    context: context,
                    text: _result,
                    success: false,
                  );
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    title: Text(
                      'Deseja realmente deletar esse usuário?',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Schoolbell',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
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
                      ),
                      TextButton(
                        child: Text(
                          'Confirmar',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: ThemeColors().pink,
                          ),
                        ),
                        onPressed: () async {
                          dynamic _result = await context
                              .read<AuthenticationService>()
                              .delete();
                          if (_result == 'Deleted') {
                            _showSnackBar(
                                context: context, text: _result, success: true);
                            await Future.delayed(Duration(seconds: 6));
                            Navigator.of(context).pop();
                          } else {
                            _showSnackBar(
                                context: context,
                                text: _result,
                                success: false);
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AuthenticationService>().signOut();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 16.0, bottom: 16.0, right: 32.0),
                child: Image.asset(
                  'assets/images/children.png',
                  height: MediaQuery.of(context).size.shortestSide -
                      kToolbarHeight -
                      32,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(
                      top: 8.0, left: 8.0, bottom: 8.0, right: 16.0),
                  child: Column(
                    children: [
                      CustomTextField(
                        labelText: 'Nome',
                        keyboardType: TextInputType.emailAddress,
                        controlador: _nameController,
                        validator: _validateName,
                      ),
                      CustomTextField(
                        labelText: 'E-mail',
                        keyboardType: TextInputType.emailAddress,
                        controlador: _emailController,
                        validator: _validateEmail,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: CustomTextField(
                              labelText: 'Senha',
                              obscureText: true,
                              lengthLimitingTextInputFormatter: 8,
                              controlador: _passwordController,
                              validator: _validatePassword,
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: CustomDropdownButtom(
                              hint: 'Sexo',
                              items: gender,
                              onChanged: (newItemSelected) {
                                _selectedGender = newItemSelected;
                              },
                              validator: _validateIsEmpty,
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: CustomDropdownButtom(
                              hint: 'Série',
                              items: grades,
                              onChanged: (newItemSelected) {
                                _selectedGrade = newItemSelected;
                              },
                              validator: _validateIsEmpty,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: CustomDropdownButtom(
                              hint: 'Nome da Escola',
                              items: schools,
                              onChanged: (newItemSelected) {
                                _selectedSchool = newItemSelected;
                              },
                              validator: _validateIsEmpty,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              /* Container(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 8.0, bottom: 8.0, right: 16.0),
                child: Column(
                  children: [
                    CustomTextField(
                      labelText: 'Nome',
                      keyboardType: TextInputType.emailAddress,
                      controlador: _nameController,
                    ),
                    CustomTextField(
                      labelText: 'E-mail',
                      keyboardType: TextInputType.emailAddress,
                      controlador: _emailController,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: CustomTextField(
                            labelText: 'Senha',
                            obscureText: true,
                            maxLength: 8,
                            controlador: _passwordController,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: CustomDropdownButtom(
                            hint: 'Sexo',
                            items: gender,
                            onChanged: (newItemSelected) {
                              _selectedGender = newItemSelected;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: CustomDropdownButtom(
                            hint: 'Série',
                            items: grades,
                            onChanged: (newItemSelected) {
                              _selectedGrade = newItemSelected;
                            },
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: CustomDropdownButtom(
                            hint: 'Nome da Escola',
                            items: schools,
                            onChanged: (newItemSelected) {
                              _selectedSchool = newItemSelected;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
             */
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar({String text, BuildContext context, bool success}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            fontFamily: 'Schoolbell',
            fontSize: 16.0,
          ),
        ),
        backgroundColor: success ? ThemeColors().blue : ThemeColors().pink,
        duration: Duration(seconds: 5),
      ),
    );
  }

  String _validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
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

  String _validateIsEmpty(String value) {
    if (value == null || value.isEmpty) {
      return 'Informe o campo';
    }
    return null;
  }

  void _resetForm() {
    setState(() {
      _emailController.clear();
      _nameController.clear();
      _passwordController.clear();
      _selectedGender = '';
      _selectedGrade = '';
      _selectedSchool = '';
    });
  }
}
