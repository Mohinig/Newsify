import 'package:flutter/material.dart';
import 'package:newsify/home.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData.dark(),
      home:HomePage(),
      debugShowCheckedModeBanner:false,
    );
  }
}

