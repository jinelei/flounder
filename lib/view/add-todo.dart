import 'package:flutter/material.dart';

class AddTodoItem extends StatefulWidget {
  @override
  _AddTodoItemState createState() => _AddTodoItemState();
}

class _AddTodoItemState extends State<AddTodoItem> {
  TextEditingController _nameTextEditingController =
      new TextEditingController();
  TextEditingController _descTextEditingController =
      new TextEditingController();

  _nameFocusNode() {
    FocusNode _nameFocusNode = new FocusNode();
    _nameFocusNode.addListener(() async {});
    return _nameFocusNode;
  }

  _descFocusNode() {
    FocusNode _descFocusNode = new FocusNode();
    _descFocusNode.addListener(() async {});
    return _descFocusNode;
  }

  _nameChanged(String str) {
    this._descTextEditingController.value = TextEditingValue(text: str);
  }

  _descChanged(String str) {}

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
                if (this._descTextEditingController.text != null &&
                    this._nameTextEditingController.text != null) {
                  Navigator.pop(context,
                      '{"name": "${_nameTextEditingController.text}", "desc": "${_descTextEditingController.text}"}');
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
              controller: _nameTextEditingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
//                  contentPadding:
//                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  icon: Icon(Icons.note_add),
                  prefixText: '名称',
                  suffixText: 'test',
                  labelText: '名称',
                  errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red))),
              onChanged: _nameChanged,
              focusNode: _nameFocusNode(),
              autofocus: false,
            ),
            TextField(
              controller: _descTextEditingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                icon: Icon(Icons.description),
                labelText: '简介',
              ),
              onChanged: _descChanged,
              focusNode: _descFocusNode(),
              autofocus: false,
            ),
          ],
        )));
  }
}
