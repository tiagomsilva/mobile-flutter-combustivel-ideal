import 'package:flutter/material.dart';

class FieldSearchComponent extends StatelessWidget {
  final TextEditingController controller;

  FieldSearchComponent(this.controller);

  @override
  Widget build(BuildContext context) {
    TextField textField = TextField(
        controller: this.controller,
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.search),
            hintText: "Buscar",
            contentPadding: EdgeInsets.all(0.0)));

    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(left: 29.0, right: 29.0),
      alignment: Alignment.center,
      height: 46.0,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xff314257), width: 1.0),
          borderRadius: BorderRadius.circular(8.0)),
      child: textField,
    );
  }
}
