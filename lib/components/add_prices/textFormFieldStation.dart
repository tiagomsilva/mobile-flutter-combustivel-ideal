import 'package:flutter/material.dart';

class TextFormFieldStationComponent extends StatelessWidget {
  final TextEditingController controller;
  final Function showSearch;

  TextFormFieldStationComponent(this.controller, this.showSearch);

  @override
  Widget build(BuildContext context) {
    InputDecoration decoration = InputDecoration(
        labelText: "Posto de Combustível",
        hintText: "Posto de Combustível",
        prefixIcon: Icon(Icons.search),
        hasFloatingPlaceholder: true,
        hintStyle: TextStyle(fontSize: 12.0),
        prefixStyle: TextStyle(fontSize: 16.0));

    return InkWell(
        onTap: this.showSearch,
        child: IgnorePointer(
          child: TextFormField(
            controller: this.controller,
            decoration: decoration,
            validator: (value) {
              if (value.isEmpty == true) {
                return "Informe o posto";
              }
            },
          ),
        ));
  }
}
