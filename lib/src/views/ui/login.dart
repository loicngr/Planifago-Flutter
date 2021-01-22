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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 100, bottom: 100),
                      child: CustomPaint(painter: DrawCircle()),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: ConstantSize.landingButtonWidth,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Email',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your email address';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}