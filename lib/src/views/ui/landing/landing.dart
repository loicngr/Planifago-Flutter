import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:planifago/src/api/auth.dart';
import 'package:planifago/src/views/utils/utils.dart';
import 'package:planifago/src/views/utils/constants.dart';
import 'package:planifago/src/views/router.dart';

class Landing extends StatefulWidget {
  final ValueNotifier<GraphQLClient> client;

  const Landing({Key key, this.client}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: landingLogoBlocHeight(context),
              width: deviceWidth(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPaint(painter: DrawCircle())
                ],
              ),
            ),
            Container(
              height: landingLogoBlocBtn(context),
              width: deviceWidth(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            Navigator.of(context).push(landingSignInRoute(widget.client));
                          },
                          child: Text("Log In",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color(ConstantColors.white), fontWeight: FontWeight.bold, fontSize: 20.00)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Forgot password',
                            style: TextStyle(fontSize: 10.00, color: Color(ConstantColors.dark_gray)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context).push(landingForgotPasswordRoute()),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: landingLogoBlocBtn(context),
              width: deviceWidth(context),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        onPressed: () {
                          Navigator.of(context).push(landingSignUpRoute(widget.client));
                        },
                        child: Text("Sign Up",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(ConstantColors.blue), fontWeight: FontWeight.bold, fontSize: 20.00)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}