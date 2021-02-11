/// Packages
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:planifago/language.dart';
import 'package:provider/provider.dart';

/// Utils
import 'package:planifago/utils/utils.dart';
import 'package:planifago/utils/constants.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  AppLanguage appLanguage;
  String languageValue = '';
  Map<String, String> languages = {};

  Future<Widget> _buildlanguage() async {
    await appLanguage.fetchLocale();

    languages = LanguageUtils.getLanguages(context);

    setState(() {
      languageValue = LanguageUtils.getKeyValue(
          languages, appLanguage.appLocal.languageCode);
    });

    return DropdownButton(
      value: languageValue,
      icon: null,
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Color(ConstantColors.black)),
      underline: null,
      onChanged: (String newValue) async {
        String value = LanguageUtils.getValueKey(languages, newValue);
        setState(() {
          languageValue = value;
        });
        appLanguage.changeLanguage(Locale(value));
      },
      items: languages.values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    appLanguage = Provider.of<AppLanguage>(context);

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: landingLanguageHeight(context),
              width: deviceWidth(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: FutureBuilder(
                          future: _buildlanguage(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                        ConnectionState.none &&
                                    snapshot.hasData == null ||
                                snapshot.data == null) {
                              return getLoader;
                            }

                            return snapshot.data;
                          })),
                ],
              ),
            ),
            Container(
              height: landingLogoBlocHeight(context),
              width: deviceWidth(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CustomPaint(painter: DrawCircle())],
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
                            Navigator.pushNamed(context, '/login');
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
                        padding: const EdgeInsets.only(top: 10.0),
                        child: RichText(
                          text: TextSpan(
                            text: AppLocalizations.of(context).forgot_password,
                            style: TextStyle(
                                fontSize: 10.00,
                                color: Color(ConstantColors.dark_gray)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // TODO - forgot password page
                                return null;
                              },
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
                                width: 1.00)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text(AppLocalizations.of(context).signup,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(ConstantColors.blue),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.00)),
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
