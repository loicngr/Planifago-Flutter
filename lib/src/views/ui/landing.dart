import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:planifago/src/views/utils/utils.dart';
import 'package:planifago/src/views/utils/constants.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 200),
                  child: CustomPaint(painter: DrawCircle()),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 250),
                  child: Column(
                    children: [
                      Material(
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(ConstantColors.blue),
                        child: MaterialButton(
                          minWidth: ConstantSize.landingButtonWidth,
                          height: ConstantSize.landingButtonHeight,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {},
                          child: Text("Log In",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color(ConstantColors.white), fontWeight: FontWeight.bold, fontSize: 20.00)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Forgot password',
                              style: TextStyle(fontSize: 10.00, color: Color(ConstantColors.dark_gray)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => print('click'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(ConstantColors.white),
                  child: Container(
                    width: ConstantSize.landingButtonWidth,
                    height: ConstantSize.landingButtonHeight,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Color(ConstantColors.blue),
                            width: 1.00
                          )
                      ),
                      onPressed: () {},
                      child: Text("Sign Up",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(ConstantColors.blue), fontWeight: FontWeight.bold, fontSize: 20.00)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}