import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyPage extends StatelessWidget {
  MyPage({this.title}) {
    _initDatabase();
  }

  final String title;

  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'author.db');
    await deleteDatabase(path);
    print('delete database');
    Database db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      /**
           * {
              "desc": "帝姓李氏，諱世民，神堯次子，聰明英武。貞觀之治，庶幾成康，功德兼隆。由漢以來，未之有也。而銳情經術，初建秦邸，即開文學館，召名儒十八人爲學士。既即位，殿左置弘文館，悉引內學士，番宿更休。聽朝之間，則與討論典籍，雜以文詠。或日昃夜艾，未嘗少怠。詩筆草隸，卓越前古。至於天文秀發，沈麗高朗，有唐三百年風雅之盛，帝實有以啓之焉。在位二十四年，諡曰文。集四十卷。館閣書目，詩一卷，六十九首。今編詩一卷。",
              "name": "太宗皇帝"
              },
           */
      await db.execute(
          'CREATE TABLE author(id INTEGER PRIMARY KEY, name TEXT, desc TEXT)');
      print('init table author');
    });
    int id1;
    await db.transaction((txn) async {
      id1 = await txn.rawInsert(
          'INSERT INTO author(name, desc) VALUES("太宗皇帝", "帝姓李氏，諱世民，神堯次子，聰明英武。貞觀之治，庶幾成康，功德兼隆。由漢以來，未之有也。而銳情經術，初建秦邸，即開文學館，召名儒十八人爲學士。既即位，殿左置弘文館，悉引內學士，番宿更休。聽朝之間，則與討論典籍，雜以文詠。或日昃夜艾，未嘗少怠。詩筆草隸，卓越前古。至於天文秀發，沈麗高朗，有唐三百年風雅之盛，帝實有以啓之焉。在位二十四年，諡曰文。集四十卷。館閣書目，詩一卷，六十九首。今編詩一卷。")');
      print('insert id: $id1');
    });
    print(await db.rawQuery('SELECT * FROM author'));
    int result = await db.rawUpdate(
        'UPDATE author SET name = ? WHERE id = ?', ["太宗皇帝1", '$id1']);
    print("update id: $id1 --> result: $result");
    print(await db.rawQuery('SELECT * FROM author'));
    int count = await db.rawDelete('DELETE from author WHERE id = ?', ['$id1']);
    print("delete id: $id1 --> result: $count");
    print(await db.rawQuery('SELECT * FROM author'));
    await db.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
          child: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      )),
    );
  }
}
