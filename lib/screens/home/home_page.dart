/// Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planifago/utils/utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  getLoader;
                  UserUtils.disconnectAsync(context)
                      .then(
                          (value) => {Navigator.popAndPushNamed(context, '/')})
                      .catchError((error) => {print(error)});
                },
                child: Icon(Icons.logout),
              )),
        ],
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text('home'),
        ),
      ),
    );
  }
}
