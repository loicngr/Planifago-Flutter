import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:planifago/src/views/ui/landing/landing.dart';
import 'package:planifago/src/views/utils/utils.dart';

class App extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  const App({Key key, this.client}) : super(key: key);

  Future<String> get userOrEmpty async {
    final _storage = new FlutterSecureStorage();

    var user = await _storage.read(key: "user");
    if (user == null) return "";
    return jsonDecode(user);
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FutureBuilder<String>(
            future: userOrEmpty,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return getLoader();
              if (snapshot.data == "") return Landing();
              return Center(
                child: Text('loading'),
              );
              /*
              TODO - user email / user password

              return FutureBuilder<http.Response>(
                future: logUser(snapshot.data.email, snapshot.data.password),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return ErrorWidget('Auth user error');
                    }
                    else if (snapshot.data.statusCode == 200) {
                      return Home();
                    } else {
                      return Landing();
                    }
                  }
                  return Center(
                    child: Text('Loading ...'),
                  );
                },
              );
              */
            }
          ),
        ),
      )
    );
  }
}