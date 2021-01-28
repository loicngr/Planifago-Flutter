import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

/**
 * Views
 */


/**
 * Api
 */
import 'package:planifago/api/auth.dart';
import 'package:planifago/api/model/users.dart';
import 'package:planifago/api/types/user.dart';
import 'package:planifago/api/users/information.dart';

/**
 * Utils / Global
 */
import 'file:///H:/dev/Planifago-Flutter/lib/globals.dart' as globals;
import 'package:planifago/utils/constants.dart';
import 'package:planifago/utils/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  bool isLoading = false;

  Map<String, String> formValues = {
    'email': null,
    'password': null
  };

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

  void formStopLoading() {
    _passwordController.clear();
    setState(() {
      isLoading = false;
    });
  }

  /// Valid form and submit
  void _validateAndSubmit() async {
    if (!_formKey.currentState.validate()) return;

    setState(() {
      isLoading = true;
    });

    var r = await logInUser(formValues);

    if (r.statusCode != 200) {
      /*
          TODO
            - Print message
        */
      print(r.reasonPhrase);

      formStopLoading();

      return;
    }

    Map<String, String> tokens = {
      'token': jsonDecode(r.body)['token'],
      'refresh_token': jsonDecode(r.body)['refresh_token']
    };

    var storeStatus = await StorageUtils.save('userJWT', jsonEncode(tokens));
    if (!storeStatus) {
      /*
          TODO
            - Print message
        */
      print("Can't save JWT");
      formStopLoading();
      return;
    }

    globals.userTokens['token'] = tokens['token'];
    globals.userTokens['refresh_token'] = tokens['refresh_token'];


    var decodedJWT = JwtUtils.decode(globals.userTokens['token']);
    String uid = decodedJWT['id'];

    final userInformation = await usersInformation(uid, context);
    if (userInformation == null) {
      /*
        TODO
          - Print message
      */
      print("Can't get user information");
      formStopLoading();
      return;
    }

    globals.userData = User.fromJson(userInformation);
    formStopLoading();
    /*
      TODO
        - Redirect to home page
     */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
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
              child: getLoader,
            ),
          ),
        ),
      ),
    );
  }
}