import 'dart:io';

import 'package:flutter/material.dart';

class ItemImageListComponent extends StatelessWidget {
  
  final String img;
  final double size;

  ItemImageListComponent(this.img, this.size);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: this.img == null
                ? AssetImage("assets/img/photo.png")
                : FileImage(File(this.img)),
          ),
        ),
      ),
    );
  }
}