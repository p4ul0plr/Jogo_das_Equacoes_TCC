import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_alert_dialog.dart';
import 'package:jogo_das_equacoes/components/custom_dropdownbuttom.dart';
import 'package:jogo_das_equacoes/components/custom_scaffold_messenger.dart';
import 'package:jogo_das_equacoes/components/custom_textfild.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/database/authentication_service.dart';
import 'package:jogo_das_equacoes/database/dao/player_dao.dart';
import 'package:jogo_das_equacoes/models/colors.dart';
import 'package:jogo_das_equacoes/models/player.dart';
import 'package:jogo_das_equacoes/models/player_status.dart';
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
  '9º ano',
  '1ª série',
  '2ª série',
  '3ª série',
  'Outra'
];

const List<String> schools = [
  'CEMAS - Colégio Estadual Misael Aguilar Silva',
  'Colégio Estadual Antonilio Da Franca Cardoso',
  'Outra'
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

  String _selectedSchool = 'Nome da Escola';
  String _selectedGrade = 'Série';
  String _selectedGender = 'Sexo';

  @override
  void initState() {
    User firebaseUser = context.read<AuthenticationService>().currentUser;
    if (firebaseUser != null) {
      Player player =
          Provider.of<PlayerProvider>(context, listen: false).player;
      _nameController = TextEditingController(text: player.name);
      _emailController = TextEditingController(text: player.email);
      _passwordController = TextEditingController(text: player.password);
      _selectedSchool = player.school;
      _selectedGrade = player.grade;
      _selectedGender = player.gender;
      print(player);
    }
    super.initState();
  }

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
            onPressed: () => _saveUser(),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteUser(),
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => _logoutUser(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            _imageUser(context),
            _formUser(),
          ],
        ),
      ),
    );
  }

  Widget _formUser() {
    return Expanded(
      flex: 7,
      child: Form(
        key: _formKey,
        child: Container(
          padding:
              EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0, right: 16.0),
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
                      hint: _selectedGender,
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
                      hint: _selectedGrade,
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
                    flex: 3,
                    child: CustomDropdownButtom(
                      hint: _selectedSchool,
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
    );
  }

  Widget _imageUser(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, bottom: 16.0, right: 8.0),
        child: Image.asset(
          'assets/images/children.png',
          height:
              MediaQuery.of(context).size.shortestSide - kToolbarHeight - 32,
        ),
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

  void _saveUser() async {
    if (_formKey.currentState.validate()) {
      /* Player player = Player(
        name: _nameController.text,
        gender: _selectedGender,
        email: _emailController.text,
        password: _passwordController.text,
        grade: _selectedGrade,
        school: _selectedSchool,
      );
      PlayerDao().newCreate(player, context); */
      dynamic _result = await context.read<AuthenticationService>().register(
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
          playerStatus: PlayerStatus(),
        );
        PlayerDao().create(user);
        Provider.of<PlayerProvider>(context, listen: false).signIn(user);
        customScaffoldMessenger(
          context: context,
          text: 'Conta criada com sucesso!',
          success: true,
        );
        Navigator.of(context).pop();
      } catch (e) {
        customScaffoldMessenger(
          context: context,
          text: _result,
          success: false,
        );
      }
    }
  }

  void _deleteUser() async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (dialogContext) {
        return CustomAlertDialog(
          text: 'Deseja realmente excluir esse usuário?',
          cancelOnPressed: () => Navigator.of(dialogContext).pop(),
          confirmOnPressed: () async {
            Navigator.of(dialogContext).pop();
            User currentUser =
                context.read<AuthenticationService>().currentUser;
            dynamic _result =
                await dialogContext.read<AuthenticationService>().delete();
            if (_result == 'O usuário foi excluído com sucesso!') {
              PlayerDao().delete(currentUser.uid);
              Provider.of<PlayerProvider>(context, listen: false).signOut();
              customScaffoldMessenger(
                context: context,
                text: _result,
                success: true,
              );
              //await Future.delayed(Duration(seconds: 5));
              Navigator.of(context).pop();
            } else {
              customScaffoldMessenger(
                context: context,
                text: _result,
                success: false,
              );
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }

  void _logoutUser() {
    showDialog(
      context: context,
      builder: (newContext) => CustomAlertDialog(
        cancelOnPressed: () => Navigator.of(newContext).pop(),
        confirmOnPressed: () {
          context.read<AuthenticationService>().signOut();
          Provider.of<PlayerProvider>(context, listen: false).signOut();
          Navigator.of(context).pop();
          Navigator.of(newContext).pop();
          /* Navigator.of(newContext).pushReplacement(
            MaterialPageRoute(
              builder: (newContext) => HomePage(),
            ),
          ); */
        },
        text: 'Tem certeza que deseja mesmo sair?',
      ),
    );
  }
}
