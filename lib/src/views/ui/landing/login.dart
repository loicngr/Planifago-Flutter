import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:planifago/src/api/auth.dart';
import 'package:planifago/src/api/types/user.dart';
import 'package:planifago/src/views/router.dart';
import 'package:planifago/src/views/utils/utils.dart';
import 'package:planifago/src/views/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:planifago/src/globals.dart' as globals;

class Login extends StatefulWidget {
  final ValueNotifier<GraphQLClient> client;
  const Login({Key key, this.client}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  Map<String, String> formValues = {
    'email': null,
    'password': null
  };

  bool isLoading = false;

  Widget _buildEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (!isEmail(value)) return "Sorry, we do not recognize this email address";
        setState(() {
          formValues['email'] = value;
        });
        return null;
      },
      style: TextStyle(color: Color(ConstantColors.black)),
      decoration: buildInputDecoration("Email", 'assets/images/email.png'),
    );
  }
  Widget _buildPassword() {
    return TextFormField(
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: TextInputType.text,
      controller: _passwordController,
      validator: (value) {
        if (value.length <= 6) return "Password must be 6 or more characters in length";
        setState(() {
          formValues['password'] = value;
        });
        return null;
      },
      style: TextStyle(color: Color(ConstantColors.black)),
      decoration:
      buildInputDecoration("Password", 'assets/images/password.png'),
    );
  }
  Widget _buildSignUpButton(BuildContext context) {
    return Container(
      height: (deviceHeight(context) / 3) - ConstantSize.landingLoginButtonHeight,
      width: deviceWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                elevation: 0.0,
                borderRadius: BorderRadius.circular(10.0),
                color: Color(ConstantColors.blue),
                child: MaterialButton(
                  minWidth: ConstantSize.landingButtonWidth,
                  height: ConstantSize.landingButtonHeight,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    _validateAndSubmit();
                  },
                  child: Text("Log In",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(ConstantColors.white), fontWeight: FontWeight.bold, fontSize: 20.00)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Back',
                    style: TextStyle(fontSize: 13.00, color: Color(ConstantColors.blue), fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => {
                        Navigator.pop(context)
                      },
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _validateAndSubmit() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
    }
  }

  _saveJWT(Map<String, String> tokens, BuildContext context) async {
    var status = await StorageUtils.save('userJWT', jsonEncode(tokens));
    if (!status) return "Error";

    globals.userTokens['token'] = tokens['token'];
    globals.userTokens['refresh_token'] = tokens['refresh_token'];
    globals.userLoginProcess = true;

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

    final _client = GraphQLProvider.of(context).value;
    final QueryOptions options = QueryOptions(
      documentNode: gql(_queryUser),
    );

    final QueryResult result = await _client.query(options);
    if (result.hasException) {
      return Text(result.exception.toString());
    }

    setState(() {
      isLoading = false;
    });

    globals.userData = User.fromJson(result.data['user']);
    Navigator.of(context).pushAndRemoveUntil(homeRoute(widget.client), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GraphQLProvider(
        client: widget.client,
        child: CacheProvider(
          child: SingleChildScrollView(
            child: Container(
              height: deviceHeight(context),
              child: (!isLoading)? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: (deviceHeight(context) / 3),
                    width: deviceWidth(context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomPaint(painter: DrawCircle()),
                      ],
                    ),
                  ),
                  Container(
                    height: (deviceHeight(context) / 3),
                    width: deviceWidth(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: ConstantSize.landingButtonWidth,
                                child: Column(
                                  children: [
                                    _buildEmail(),
                                    _buildPassword()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildSignUpButton(context)
                ],
              ) : Center(
                child: FutureBuilder<http.Response>(
                  future: logUser(formValues),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return ErrorWidget('Auth user error');
                      }
                      else if (snapshot.data.statusCode == 200) {
                        Map<String, String> tokens = {
                          'token': jsonDecode(snapshot.data.body)['token'],
                          'refresh_token': jsonDecode(snapshot.data.body)['refresh_token']
                        };

                        _saveJWT(tokens, context);
                      } else if (snapshot.data.statusCode == 401) {
                        /// TODO print chill error message
                      }
                    }
                    return getLoader;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}