import 'package:flutter/material.dart';

class TextFormFieldComponent extends StatelessWidget {

  final String placeholder;
  final TextEditingController controller;
  final String errorText;
  final String sufixText;
  final TextInputType typeKeyboard;

  TextFormFieldComponent(this.placeholder, this.controller, this.errorText, {this.sufixText, this.typeKeyboard});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      keyboardType: typeKeyboard?? TextInputType.text,
      decoration: InputDecoration(
        labelText: this.placeholder,
        hintText: this.placeholder,
        suffixText: this.sufixText,
        hintStyle: TextStyle(fontSize: 12.0),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return this.errorText;
        }
      },
    );
  }
}