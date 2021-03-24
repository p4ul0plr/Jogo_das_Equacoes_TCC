import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_dropdownbuttom.dart';
import 'package:jogo_das_equacoes/components/custom_textfild.dart';
import 'package:jogo_das_equacoes/components/custom_title.dart';
import 'package:jogo_das_equacoes/models/user.dart';

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

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _selectedSchool;
  String _selectedGrade;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(
          title: 'Conta',
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              User user = new User(
                name: _nameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                grade: _selectedGrade,
                school: _selectedSchool,
              );
              print(user);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 16.0, bottom: 16.0, right: 32.0),
                child: Image.asset(
                  'assets/images/user.png',
                  height: MediaQuery.of(context).size.shortestSide -
                      kToolbarHeight -
                      32,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(8.0),
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
                    CustomTextField(
                      labelText: 'Senha',
                      obscureText: true,
                      lengthLimitingTextInputFormatter: 8,
                      controlador: _passwordController,
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
                              print(_selectedGrade);
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
                              print(_selectedSchool);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
