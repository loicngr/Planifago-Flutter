/// Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:planifago/utils/constants.dart';

// Utils / Constants
import 'package:planifago/utils/utils.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String languageValue = '';

  Widget _buildLogout() {
    return TextButton(
        onPressed: () {
          getLoader;
          UserUtils.disconnectAsync(context)
              .then((value) => {Navigator.popAndPushNamed(context, '/')})
              .catchError((error) => {print(error)});
        },
        child: Text(AppLocalizations.of(context).logout));
  }

  Future<Widget> _buildlanguage() async {
    final appDefaultLanguage = await StorageUtils.get('settings', 'language');

    setState(() {
      languageValue = appDefaultLanguage;
    });

    return DropdownButton(
      value: languageValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) async {
        setState(() {
          languageValue = newValue;
        });
        await StorageUtils.save('settings', 'language', newValue);
        AlertUtils.showMyDialogAndRestart(context);
      },
      items: <String>['fr', 'en'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Future<List<Widget>> _initWidgets() async {
    return [_buildLogout(), await _buildlanguage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: TextStyle(color: Color(ConstantColors.black))),
        centerTitle: true,
        backgroundColor: Color(ConstantColors.white),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(ConstantColors.black)),
      ),
      body: FutureBuilder(
          future: _initWidgets(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                    snapshot.hasData == null ||
                snapshot.data == null) {
              return getLoader;
            }

            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    color: Color(ConstantColors.light_gray),
                    child: Center(child: snapshot.data[index]),
                  );
                });
          }),
    );
  }
}
