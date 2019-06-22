import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final String labelText;
  final String prefixText;
  final Icon prefixIcon;
  final TextInputType keyboardType;

  TextFieldComponent(this.labelText, {this.prefixText, this.prefixIcon, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    InputDecoration decoration = InputDecoration(
        labelText: labelText,
        hintText: labelText,
        prefixText: this.prefixText,
        prefixIcon: this.prefixIcon,
        hasFloatingPlaceholder: true, 
        hintStyle: TextStyle(fontSize: 12.0),
        prefixStyle: TextStyle(fontSize: 16.0));

    TextField textField = TextField(
      decoration: decoration,
      keyboardType: this.keyboardType ?? TextInputType.text,
    );

    return textField;
  }
}
