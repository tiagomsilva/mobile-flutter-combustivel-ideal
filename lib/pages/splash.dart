import 'package:combustivel_ideal/pages/list_stations.dart';
import 'package:flutter/material.dart';

class SplashHome extends StatefulWidget {
  @override
  _SplashHomeState createState() => _SplashHomeState();
}

class _SplashHomeState extends State<SplashHome> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ListStations()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.5, 0.9],
            colors: [
              Color(0xff141B24),
              Theme.of(context).primaryColor,
              Color(0xff314257),
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: 140,
            height: 212,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/logo.png")),
            ),
          ),
        ),
      ),
    );
  }
}
