import 'package:flutter/material.dart';
import './random_words.dart';

void main() => runApp(BasicApp());

class BasicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.black), home: RandomWords());
  }
}
