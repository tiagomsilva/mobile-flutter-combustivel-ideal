import 'package:flutter/material.dart';

class RaisedButtonComponent extends StatelessWidget {

  final String text;
  final Function function;

  RaisedButtonComponent(this.text, { this.function });

  @override
  Widget build(BuildContext context) {
    return 
        SizedBox(
          width: double.infinity,
          child: RaisedButton(
            child: Text(this.text),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            onPressed: this.function,
          ),
        );
  }
}