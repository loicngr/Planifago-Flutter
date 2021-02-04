/// Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Utils / Constants
import 'package:planifago/utils/constants.dart';
import 'package:planifago/utils/utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        child: Center(
          child: Text(AppLocalizations.of(context).home),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (value) {
          switch (value) {
            case 0:
              // TODO - push to search page
              break;
            case 1:
              // TODO - push to add page
              break;
            case 2:
              // TODO - push to settings page
              Navigator.pushNamed(context, '/settings');
              break;
            default:
              break;
          }
        },
        items: [
          buildbottomNavigationBarItem(
              AppLocalizations.of(context).search, 'assets/images/search.png'),
          buildbottomNavigationBarItem(
              AppLocalizations.of(context).add, 'assets/images/add.png'),
          buildbottomNavigationBarItem(AppLocalizations.of(context).settings,
              'assets/images/settings.png'),
        ],
      ),
    );
  }
}
