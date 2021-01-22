import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:planifago/src/views/utils/utils.dart';
import 'package:planifago/src/views/utils/constants.dart';
import 'package:planifago/src/views/router.dart';

class Landing extends StatelessWidget {

  /// Retourne la taille de l'espacement pour le logo
  /// en fonction de la hauteur des boutons et de la hauteur de l'écran
  double getLogoPadding(BuildContext c) {
    var btnHeight = (ConstantSize.landingButtonHeight * 2) - ConstantSize.landingButtonsPaddingHeight;
    var h = ((deviceHeight(c) / 2) - btnHeight);
    print(h);
    return h;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: deviceHeight(context),
          width: deviceWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: getLogoPadding(context)),
                    child: CustomPaint(painter: DrawCircle()),
                  ),
                ],
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
                            Navigator.of(context).push(landingSignInRoute());
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
                              ..onTap = () => Navigator.of(context).push(landingSignInRoute()),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(padding: const EdgeInsets.only(bottom: 30.0)),
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
              Padding(padding: const EdgeInsets.only(bottom: 50.0)),
            ],
          ),
        ),
      ),
    );
  }
}