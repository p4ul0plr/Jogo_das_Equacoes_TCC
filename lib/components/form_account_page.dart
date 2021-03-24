import 'package:flutter/material.dart';
import 'package:jogo_das_equacoes/components/custom_dropdownbuttom.dart';
import 'package:jogo_das_equacoes/components/custom_textfild.dart';
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
const List<String> gender = ['Masculino', 'Feminino', 'Outro'];

class FormAccountPage extends StatefulWidget {
  @override
  _FormAccountPageState createState() => _FormAccountPageState();
}

class _FormAccountPageState extends State<FormAccountPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _selectedSchool;
  String _selectedGrade;
  String _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      flex: 2,
                      child: CustomTextField(
                        labelText: 'Senha',
                        obscureText: true,
                        lengthLimitingTextInputFormatter: 8,
                        controlador: _passwordController,
                        validator: _validateIsEmpty,
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
                        hint: 'Série',
                        items: grades,
                        onChanged: (newItemSelected) {
                          _selectedGrade = newItemSelected;
                        },
                        validator: _validateIsEmpty,
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
                        validator: _validateIsEmpty,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate()) {
                        // Process data.
                        User user = new User(
                          name: _nameController.text,
                          gender: _selectedGender,
                          email: _emailController.text,
                          password: _passwordController.text,
                          grade: _selectedGrade,
                          school: _selectedSchool,
                        );
                        print(user);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
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

  String _validateIsEmpty(String value) {
    if (value == null || value.isEmpty) {
      return 'Informe o campo solicitado';
    }
    return null;
  }
}
