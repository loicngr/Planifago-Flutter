import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:planifago/src/views/utils/utils.dart';
import 'package:planifago/src/views/utils/constants.dart';
import 'package:planifago/src/views/router.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  Widget _buildEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) => !isEmail(value) ? "Sorry, we do not recognize this email address" : null,
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
      validator: (value) =>
      value.length <= 6 ? "Password must be 6 or more characters in length" : null,
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

  _validateAndSubmit() {
    if (_formKey.currentState.validate()) {
      print('validate form');
      // _formKey.currentState.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: deviceHeight(context),
            child: Column(
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
            ),
          ),
        ),
      ),
    );
  }
}
