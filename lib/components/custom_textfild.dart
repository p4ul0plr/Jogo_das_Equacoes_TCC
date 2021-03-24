import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final int lengthLimitingTextInputFormatter;
  final TextEditingController controlador;

  CustomTextField({
    this.labelText,
    this.obscureText = false,
    this.keyboardType,
    this.lengthLimitingTextInputFormatter,
    this.controlador,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: TextField(
        controller: controlador,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          labelText: labelText,
          enabledBorder: customOutlineInputBorder(),
          focusedBorder: customOutlineInputBorder(),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(lengthLimitingTextInputFormatter),
        ],
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
