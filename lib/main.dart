import 'package:flounder/view/home.dart';
import 'package:flounder/view/author.dart';
import 'package:flounder/view/scanqr.dart';
import 'package:flutter/material.dart';

import 'package:flounder/view/my-page.dart';

void main() {
  runApp(FlounderApp());
}

class FlounderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flounder',
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => MyPage(title: 'page a'),
        '/b': (BuildContext context) => MyPage(title: 'page b'),
        '/c': (BuildContext context) => MyPage(title: 'page c'),
        '/author': (BuildContext context) => Author('authors.tang.json'),
        '/scan':(BuildContext context) => ScanQR(),
      },
    );
  }
}
