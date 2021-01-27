import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:planifago/src/views/ui/home.dart';
import 'package:planifago/src/views/ui/landing/landing.dart';
import 'package:planifago/src/views/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:planifago/src/globals.dart' as globals;

import 'api/auth.dart';
import 'api/types/user.dart';

class App extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  const App({Key key, this.client}) : super(key: key);

  final String _queryUser = """
  {
    user(id: "/api/users/1") {
      id,
      plan { id },
      email,
      roles,
      firstname,
      lastname,
      phone,
      isActive,
      avatar,
      createdAt,
      updatedAt
    }
  }
  """;

  /*

  TODO - When user login
    Make Query and to get user data and redirect to Home page

   */

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: client,
        child: CacheProvider(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: FutureBuilder<Map<dynamic, dynamic>>(
                future: StorageUtils.userJWT,
                builder: (context, snapshot) {
                  if (snapshot.data == null) return Landing(client: client);
                  else if (snapshot.data != null) {
                    Map<String, dynamic> decodedToken = JwtDecoder.decode(snapshot.data['token']);
                    // final String userEmail = decodedToken['username'];
                    /// TODO - Get user id with JWT

                    return Query(
                        options: QueryOptions(
                          documentNode: gql(_queryUser),
                        ),
                        builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
                          if (result.hasException) {
                            return Text(result.exception.toString());
                          }

                          if (!result.loading) {
                            globals.userData = User.fromJson(result.data['user']);
                            return Home(client: client);
                          }

                          return (result.loading)? getLoader : Container(
                            child: Center(
                              child: Text('success'),
                            ),
                          );
                        }
                    );
                  }

                  return getLoader;
                }
            ),
          ),
        )
    );
  }
}

/*

FutureBuilder<http.Response>(
                      future: ,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return ErrorWidget('Auth user error');
                          }
                          else if (snapshot.data.statusCode == 200) {
                            return Home(client: client);
                          } else {
                            /// return Landing(client: client);
                            /// TODO : Generate new token with refresh token
                          }
                        }
                        return Landing(client: client);
                      },
                    )


 */