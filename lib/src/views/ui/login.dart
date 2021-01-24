import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:planifago/src/views/utils/utils.dart';
import 'package:planifago/src/views/utils/constants.dart';
import 'package:planifago/src/views/router.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      hintText: 'Email',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter your email address';
                                      }
                                      else if (!isEmail(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      hintText: 'Password',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
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
                                if (_formKey.currentState.validate()) {
                                  print('log in !!');
                                  // _formKey.currentState.reset();
                                }
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
                                    Navigator.of(context).push(landingRoute())
                                  },
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
