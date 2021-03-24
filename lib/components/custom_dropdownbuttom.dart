import 'package:flutter/material.dart';

typedef OnChangeCallback = void Function(dynamic value);

// ignore: must_be_immutable
class CustomDropdownButtom extends StatefulWidget {
  final List<String> items;
  final String hint;
  final OnChangeCallback onChanged;

  CustomDropdownButtom({this.items, this.hint, this.onChanged});

  @override
  _CustomDropdownButtomState createState() => _CustomDropdownButtomState();
}

class _CustomDropdownButtomState extends State<CustomDropdownButtom> {
  String selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16.0, left: 16.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton<String>(
        value: selectedItem,
        hint: Text(widget.hint),
        isExpanded: true,
        underline: SizedBox(),
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
      ),
    );
  }
}
