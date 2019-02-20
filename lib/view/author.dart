import 'package:flounder/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Author extends StatefulWidget {
  Author(String authorType) {
    this._authorType = authorType;
  }

  String _authorType = 'authors.tang.json';

  @override
  _AuthorState createState() => _AuthorState(_authorType);
}

class _AuthorState extends State<Author> {
  _AuthorState(authorType) {
    print(authorType);
    this._authorType = authorType;
    this._loading = false;
  }

  String _authorType;
  String _failedReason;
  List _authorList;
  bool _loading = true;
  bool _fetchFailed = false;

  _getAuthor() async {
    var url =
        'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/json/' +
            this._authorType;
    var httpClient = new HttpClient();

    List result;
    String exceptionResult;
    bool fetchFailed = true;
    try {
      setState(() {
        _loading = true;
      });
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        String originStr = await response.transform(utf8.decoder).join();
        result = jsonDecode(originStr);
        fetchFailed = false;
      } else {
        exceptionResult =
            'Error getting author:\nHttp status ${response.statusCode}\n ${url}';
      }
    } catch (exception) {
      exceptionResult = 'Failed getting author\n ${exception}';
    }
    if (!mounted) return;
    setState(() {
      _loading = false;
      _fetchFailed = fetchFailed;
      if (fetchFailed) {
        _failedReason = exceptionResult;
      } else {
        _authorList = result;
      }
    });
  }

  Widget childWidget() {
    Widget childWidget;
    if (this._loading) {
      childWidget = new Stack(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 35.0),
            child: new Center(
              child: SpinKitFadingCircle(
                color: Colors.blueAccent,
                size: 30.0,
              ),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
            child: new Center(
              child: new Text('正在加载中，莫着急哦~'),
            ),
          ),
        ],
      );
    } else if (this._fetchFailed == true || this._authorList == null) {
      childWidget = new Stack(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 35.0),
            child: new Center(
              child: Icon(Icons.sms_failed),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
            child: new Center(
              child: new Text('加载失败\n$_failedReason'),
            ),
          ),
        ],
      );
    } else {
      childWidget = new Padding(
        padding: EdgeInsets.all(6.0),
        child: new ListView.builder(
          itemCount: this._authorList.length,
          itemBuilder: (context, index) {
            var author = json.decode(json.encode(this._authorList[index]));
            return new ListTile(
              title: new Text('${author["name"]}'),
              subtitle: Text('${author["desc"]}'),
              trailing: Icon(Icons.navigate_next),
            );
          },
        ),
      );
    }
    return childWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("author list"),
      ),
      drawer: Utils.gengerateDrawer(context),
      body: Center(
        child: childWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getAuthor,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AuthorObject {
  final String name;
  final String desc;

  AuthorObject(this.name, this.desc);

  AuthorObject.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        desc = json['desc'];

  Map<String, dynamic> toJson() => {'name': name, 'desc': desc};
}
