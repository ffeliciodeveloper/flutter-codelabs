import 'package:flutter/material.dart';
import 'package:secondflutterapp/randomWords.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Second Flutter App',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: RandomWords()
    );
  }
}
