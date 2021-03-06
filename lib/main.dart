import 'package:flutter/material.dart';
import 'package:toppers_pakistan/pages/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xffbc282b),
        accentColor: Color(0xffCE862A),
      ),
      home: HomePage(),
    );
  }
}
