import 'package:flutter/material.dart';

typedef OnChangeCallback = void Function(dynamic value);

// ignore: must_be_immutable
class CustomDropdownButtom extends StatefulWidget {
  final List<String> items;
  final String hint;
  final OnChangeCallback onChanged;
  final String Function(String) validator;

  CustomDropdownButtom({
    this.items,
    this.hint,
    this.onChanged,
    this.validator,
  });

  @override
  _CustomDropdownButtomState createState() => _CustomDropdownButtomState();
}

class _CustomDropdownButtomState extends State<CustomDropdownButtom> {
  String selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: EdgeInsets.only(right: 16.0, left: 16.0),
      padding: EdgeInsets.all(8.0),
      /* decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(15),
      ), */
      child: DropdownButtonFormField<String>(
        value: selectedItem,
        hint: Text(widget.hint),
        isExpanded: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.only(right: 16.0, left: 16.0),
          enabledBorder: customOutlineInputBorder(),
          focusedBorder: customOutlineInputBorder(),
          errorBorder: customOutlineInputBorder(),
          focusedErrorBorder: customOutlineInputBorder(),
        ),
        //Remover underline para DropdownButtonFormField
        /* decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0,
            ),
          ),
        ), */
        //underline: SizedBox(), //Remover underline para DropdownButton
        items: widget.items.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(dropDownStringItem),
          );
        }).toList(),
        onChanged: (String newselectedItem) {
          setState(() {
            selectedItem = newselectedItem;
          });
          widget.onChanged(newselectedItem);
        },
        validator: widget.validator,
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
