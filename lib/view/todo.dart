import 'dart:convert';
import 'package:flounder/utils/utils.dart';
import 'package:flounder/view/add-todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cached_network_image/cached_network_image.dart';

final String createTodoTable =
    'CREATE TABLE todo(id INTEGER PARMARY KEY, name TEXT, desc TEXT, state INTEGER)';
final String insertTodoTable =
    'INSERT INTO todo(id, name, desc, state) VALUES(?,?,?,?)';
final String updateTodoTable =
    'UPDATE TABLE todo SET name = ?, desc = ?, state = ? WHERE id = ?';
final String deleteTodoTable = 'DELETE FROM todo WHERE id = ?';
final String queryTodoTable = 'SELECT * FROM todo';

final String imageUrl =
    'https://cdn.jsdelivr.net/gh/flutterchina/website@1.0/images/flutter-mark-square-100.png';

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  _TodoState() {
    _initDatabase();
  }

  Database todoDB;
  int _offset = 0;
  List<Map> _todoList;
  double _itemHeight = 60.0;
  ScrollController _scrollController = new ScrollController();

  _initDatabase() async {
    String todoPath = join(await getDatabasesPath(), 'todo.db');
    this.todoDB = await openDatabase(todoPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(createTodoTable);
      print('create table todo');
    });
    _refreshTodoList();
  }

  _refreshTodoList() async {
    List<Map> todoList = await this.todoDB.rawQuery(queryTodoTable);
    setState(() {
      this._todoList = todoList;
    });
  }

  _addTodoItem() async {
    var id = new DateTime.now().millisecondsSinceEpoch;
    this.todoDB.rawInsert(
        insertTodoTable, ['$id', 'test $_offset', 'test desc $_offset', '1']);
    this._refreshTodoList();
    if (this._todoList != null && this._todoList.length != 0) {
      double scrollTo = this._itemHeight * (this._todoList.length - 1);
      this._scrollController.animateTo(scrollTo,
          duration: Duration(seconds: 1), curve: Curves.ease);
    }
    setState(() {
      _offset = _offset + 1;
    });
  }

  _removeTodoItem(id) async {
    this.todoDB.rawDelete(deleteTodoTable, ['$id']);
    this._refreshTodoList();
  }

  Widget childWidget() {
    Widget childWidget;
    if (this._todoList == null) {
      childWidget = Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 35.0),
            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.blueAccent,
                size: 30.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
            child: Center(
              child: Text('正在加载中，莫着急哦~'),
            ),
          ),
        ],
      );
    } else {
      childWidget = ListView.builder(
        controller: _scrollController,
        itemCount: this._todoList.length,
        itemBuilder: (context, index) {
          var _item = json.decode(json.encode(this._todoList[index]));
//            print(_item);
          if (this._itemHeight == null) {
            this._itemHeight =
                context.findRenderObject().paintBounds.size.height;
          }
          return Dismissible(
            crossAxisEndOffset: 300.0,
            key: Key(_item["name"]),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
//                  this._todoList.removeAt(index);
              _removeTodoItem(_item["id"]);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("$_item dismissed"),
                duration: Duration(milliseconds: 100),
              ));
            },
            child: Container(
              height: _itemHeight,
              child: ListTile(
                leading: new CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
                title: Text('${_item["name"]}'),
                subtitle: Text('id: ${_item["id"]}    ${_item["desc"]}'),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
          );
        },
      );
    }
    return childWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('todo'),
      ),
      drawer: Utils.gengerateDrawer(context),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: childWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddTodoItem()));
          print('result: $result');
          if (result != null) {
            _addTodoItem();
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
