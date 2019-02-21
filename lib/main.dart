import 'dart:collection';

import 'package:flounder/view/home.dart';
import 'package:flounder/view/author.dart';
import 'package:flounder/view/scanqr.dart';
import 'package:flounder/view/todo.dart';
import 'package:flutter/material.dart';
import 'package:flounder/view/my-page.dart';

void main() {
  runApp(FlounderApp());
}

Widget homeWidget = Todo();
Map<String, WidgetBuilder> views = <String, WidgetBuilder>{
  '/b': (BuildContext context) => MyPage(title: 'page b'),
  '/c': (BuildContext context) => MyPage(title: 'page c'),
  '/author': (BuildContext context) => Author('authors.tang.json'),
  '/scan': (BuildContext context) => ScanQR(),
  '/todo': (BuildContext context) => Todo(),
};

class FlounderApp extends StatelessWidget {
  FlounderApp() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flounder',
      home: homeWidget,
      routes: views,
    );
  }
}
