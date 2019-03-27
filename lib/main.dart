import 'package:flutter/material.dart';
import 'package:flutter_stopwatch/pages/home.dart';

void main() => runApp(Stopwatch());

class Stopwatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeWidget(),
    );
  }
}
