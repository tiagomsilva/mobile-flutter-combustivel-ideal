import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;

  TextComponent(this.text, {this.color, this.size, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    Text text = Text(
      this.text,
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize: this.size ?? 12.0,
          fontWeight: this.fontWeight ?? FontWeight.bold),
    );

    return text;
  }
}
