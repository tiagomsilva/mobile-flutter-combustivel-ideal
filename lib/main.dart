import 'package:combustivel_ideal/pages/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Combustível ideal",
    home: SplashHome(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color(0xff314257),
    ),
  ));
}
