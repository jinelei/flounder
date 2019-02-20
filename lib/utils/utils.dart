import 'package:flutter/material.dart';

class utils {
  static gengerateDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 30),
        children: <Widget>[
          ListTile(
            title: Text('home'),
            leading: CircleAvatar(
              child: Icon(Icons.home),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            title: Text('author'),
            leading: CircleAvatar(
              child: Icon(Icons.home),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/author');
            },
          ),
          ListTile(
            title: Text('scan'),
            leading: CircleAvatar(
              child: Icon(Icons.camera),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/scan');
            },
          ),
          ListTile(
            title: Text('page a'),
            leading: CircleAvatar(
              child: Icon(Icons.access_alarm),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/a');
            },
          ),
          ListTile(
            title: Text('page b'),
            leading: CircleAvatar(
              child: Icon(Icons.book),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/b');
            },
          ),
          ListTile(
            title: Text('page c'),
            leading: CircleAvatar(
              child: Icon(Icons.change_history),
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
