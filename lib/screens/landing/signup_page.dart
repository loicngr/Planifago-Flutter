/// Packages
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Views

/// Api
import 'package:planifago/api/users/signup.dart';

/// Utils / Globals
import 'package:planifago/utils/constants.dart';
import 'package:planifago/utils/utils.dart';

/// Router

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  bool isLoading = false;

  Map<String, String> formValues = {
    'firstname': null,
    'lastname': null,
    'email': null,
    'password': null
  };

  Widget _buildFirstName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) return "First name cannot be empty";
        setState(() {
          formValues['firstname'] = value;
        });
        return null;
      },
      style: TextStyle(color: Color(ConstantColors.black)),
      decoration: buildInputDecoration("First name", 'assets/images/user.png'),
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) return "Last name cannot be empty";
        setState(() {
          formValues['lastname'] = value;
        });
        return null;
      },
      style: TextStyle(color: Color(ConstantColors.black)),
      decoration: buildInputDecoration("Last name", 'assets/images/user.png'),
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (!isEmail(value))
          return "Sorry, we do not recognize this email address";
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
        if (value.length <= 6)
          return "Password must be 6 or more characters in length";
        return null;
      },
      style: TextStyle(color: Color(ConstantColors.black)),
      decoration:
          buildInputDecoration("Password", 'assets/images/password.png'),
    );
  }

  Widget _buildConfirmPassword() {
    return TextFormField(
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty ||
            value.isNotEmpty && value != _passwordController.text)
          return "Must match the previous entry";
        setState(() {
          formValues['password'] = value;
        });
        return null;
      },
      style: TextStyle(color: Color(ConstantColors.black)),
      decoration: buildInputDecoration(
          "Confirm password", 'assets/images/password.png'),
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
                  child: Text("Log In",
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
                    text: 'Back',
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

    final userID = await usersSignUp(formValues, context);
    if (userID == null) {
      AlertUtils.showMyDialog(
          context, "Sign Up status", "Account not created.");
      formStopLoading();
      return;
    }

    Navigator.popAndPushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: deviceHeight(context),
            ),
            child: IntrinsicHeight(
              child: (!isLoading)
                  ? Column(
                      children: <Widget>[
                        Container(
                          height: (deviceHeight(context) / 3) +
                              ConstantSize.landingLogoHeight,
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
                                          _buildFirstName(),
                                          _buildLastName(),
                                          _buildEmail(),
                                          _buildPassword(),
                                          _buildConfirmPassword(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(child: _buildSignUpButton(context))
                      ],
                    )
                  : Center(
                      child: getLoader,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
