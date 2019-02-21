import 'package:flutter/material.dart';

class AddTodoItem extends StatefulWidget {
  @override
  _AddTodoItemState createState() => _AddTodoItemState();
}

class _AddTodoItemState extends State<AddTodoItem> {
  String _name;
  String _desc;
  int _status;

  _nameChanged(String str) {
    print('name: $str');
    setState(() {
      this._name = str;
    });
  }

  _descChanged(String str) {
    print('desc: $str');
    setState(() {
      this._desc = str;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('add todo'),
          actions: <Widget>[
            FlatButton(
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                if (this._desc != null && this._name != null) {
                  Navigator.pop(
                      context, '{"name": "$_name", "desc": "$_desc"}');
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('not empty'),
                          ));
                }
              },
            )
          ],
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                icon: Icon(Icons.text_fields),
                labelText: '名称',
              ),
              onChanged: _nameChanged,
              autofocus: false,
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                icon: Icon(Icons.text_fields),
                labelText: '名称',
              ),
              onChanged: _descChanged,
              autofocus: false,
            ),
          ],
        ))
//      Container(
//        child: Column(
//          children: <Widget>[
//            Row(
//              children: <Widget>[
//                TextField(
//                  keyboardType: TextInputType.number,
//                  decoration: InputDecoration(
//                    contentPadding: EdgeInsets.all(10.0),
//                    icon: Icon(Icons.text_fields),
//                    labelText: '请输入你的姓名)',
//                    helperText: '请输入你的真实姓名',
//                  ),
//                  onChanged: _textFieldChanged,
//                  autofocus: false,
//                ),
//              ],
//            ),
//            Row(
//              children: <Widget>[Text('desc')],
//            )
//          ],
//        ),
//      ),
        );
  }
}
