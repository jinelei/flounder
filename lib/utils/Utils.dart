import 'package:flutter/material.dart';

class Utils {
  static gengerateDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 30),
        children: <Widget>[
          ListTile(
            title: Text('home'),
            leading: new CircleAvatar(
              child: new Icon(Icons.home),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            title: Text('author'),
            leading: new CircleAvatar(
              child: new Icon(Icons.home),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/author');
            },
          ),
          ListTile(
            title: Text('page a'),
            leading: new CircleAvatar(
              child: new Icon(Icons.access_alarm),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/a');
            },
          ),
          ListTile(
            title: Text('page b'),
            leading: new CircleAvatar(
              child: new Icon(Icons.book),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/b');
            },
          ),
          ListTile(
            title: Text('page c'),
            leading: new CircleAvatar(
              child: new Icon(Icons.change_history),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/c');
            },
          ),
        ],
      ),
    );
  }
}
