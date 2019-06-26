import 'dart:io';

import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {

  final String img;
  final Function function;

  ImageComponent(this.img, this.function);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: this.img == null ? 80.0 : 140.0,
        height: this.img == null ? 70.0 : 140.0,
        decoration: BoxDecoration(
          shape:
              this.img == null ? BoxShape.rectangle : BoxShape.circle,
          image: DecorationImage(
            fit: this.img == null ? BoxFit.fill : BoxFit.fitWidth,
            image: this.img == null
                ? AssetImage("assets/img/photo.png")
                : FileImage(File(this.img)),
          ),
        ),
      ),
      onTap: function,
    );
  }
}