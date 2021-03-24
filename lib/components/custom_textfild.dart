import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLength;
  final TextEditingController controlador;
  final String Function(String) validator;
  final int lengthLimitingTextInputFormatter;

  CustomTextField({
    this.labelText,
    this.obscureText = false,
    this.keyboardType,
    this.maxLength,
    this.controlador,
    this.validator,
    this.lengthLimitingTextInputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: TextFormField(
        controller: controlador,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLength: maxLength,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          labelText: labelText,
          enabledBorder: customOutlineInputBorder(),
          focusedBorder: customOutlineInputBorder(),
          errorBorder: customOutlineInputBorder(),
          focusedErrorBorder: customOutlineInputBorder(),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(lengthLimitingTextInputFormatter),
        ],
        validator: validator,
        /* validator: (String value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        }, */
      ),
    );
  }

  OutlineInputBorder customOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1),
      borderRadius: BorderRadius.circular(15),
    );
  }
}
