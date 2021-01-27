import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:planifago/src/globals.dart' as globals;
import 'package:planifago/src/views/utils/utils.dart';
import 'package:planifago/src/views/router.dart';

class Home extends StatefulWidget {
  final ValueNotifier<GraphQLClient> client;
  const Home({Key key, this.client}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  globals.userTokens = null;
                  globals.userData = null;
                  await StorageUtils.delete('userJWT');
                  Navigator.of(context).pushAndRemoveUntil(landingRoute(widget.client), (route) => false);
                },
                child: Icon(
                    Icons.logout
                ),
              )
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}