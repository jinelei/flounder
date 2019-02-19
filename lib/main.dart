import 'package:flutter/material.dart';
import 'package:flounder/view/click-counter.dart';

void main() => runApp(FlounderApp());

class FlounderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClickCounter(),
    );
  }
}
