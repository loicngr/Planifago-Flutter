import 'dart:convert';

/// Packages
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Views

/// Api
import 'package:planifago/api/auth.dart';
import 'package:planifago/api/users/information.dart';

/// Utils / Globals
import 'package:planifago/globals.dart' as globals;
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

  Map<String, String> formValues = {'email': null, 'password': null};

  Widget _buildEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (!isEmail(value))
          return AppLocalizations.of(context).form_error_email_malformed;
        setState(() {
          formValues['email'] = value;
        });
        return null;
      },
      style: TextStyle(color: Color(ConstantColors.black)),
      decoration: buildInputDecoration(
          AppLocalizations.of(context).email, 'assets/images/email.png'),
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
        if (value.length <= 6)
          return AppLocalizations.of(context).form_error_password_malformed;
        setState(() {
          formValues['password'] = value;
        });
        return null;
      },
      style: TextStyle(color: Color(ConstantColors.black)),
      decoration: buildInputDecoration(
          AppLocalizations.of(context).password, 'assets/images/password.png'),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Container(
      height:
          (deviceHeight(context) / 3) - ConstantSize.landingLoginButtonHeight,
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
                  child: Text(AppLocalizations.of(context).login,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(ConstantColors.white),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.00)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context).back,
                    style: TextStyle(
                        fontSize: 13.00,
                        color: Color(ConstantColors.blue),
                        fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => {Navigator.pop(context)},
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

    var r =
        await RequestUtils.tryCatchRequest(context, logInUser, [formValues]);

    if (r == null || r.statusCode != 200) {
      if (r != null) {
        AlertUtils.showMyDialog(
            context,
            AppLocalizations.of(context).login_status,
            AppLocalizations.of(context).account_not_found);
        if (globals.debugMode) {
          print(r.reasonPhrase);
        }
      } else {
        AlertUtils.showMyDialog(
            context,
            AppLocalizations.of(context).login_status,
            AppLocalizations.of(context).error_occurred);
      }

      formStopLoading();
      return;
    }

    Map<String, String> tokens = {
      'token': jsonDecode(r.body)['token'],
      'refresh_token': jsonDecode(r.body)['refresh_token']
    };

    /// Save JWT (accessToken / refreshToken) in app storage
    var storeStatus = await StorageUtils.saveJWT(
        'jwt', tokens['token'], tokens['refresh_token']);
    if (!storeStatus) {
      AlertUtils.showMyDialog(
          context,
          AppLocalizations.of(context).login_status,
          AppLocalizations.of(context).error_occurred_saving);
      if (globals.debugMode) {
        print("Can't save JWT");
      }

      formStopLoading();
      return;
    }

    /// Decode JWT
    var decodedJWT = JwtUtils.decode(tokens['token']);
    if (!decodedJWT.containsKey('id')) {
      AlertUtils.showMyDialog(
          context,
          AppLocalizations.of(context).login_status,
          AppLocalizations.of(context).error_occurred_parsing);
      formStopLoading();
      return;
    }

    String uid = decodedJWT['id']; // = /api/users/{id}

    /// Get user information (GraphQL)
    final userInformation = await usersInformation(uid, context);
    if (userInformation == null) {
      AlertUtils.showMyDialog(
          context,
          AppLocalizations.of(context).login_status,
          AppLocalizations.of(context).error_cannot_get_your_information);
      formStopLoading();
      return;
    }

    /// Save user to app storage
    StorageUtils.saves('user', userInformation);
    formStopLoading();
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false,
        arguments: {'title': AppLocalizations.of(context).home});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: deviceHeight(context),
            child: (!isLoading)
                ? Column(
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
                  )
                : Center(
                    child: getLoader,
                  ),
          ),
        ),
      ),
    );
  }
}
