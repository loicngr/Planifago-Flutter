import 'dart:async';

/// Packages
import 'package:flutter_localizations/flutter_localizations.dart';

// uncomment the line below after codegen
/// https://flutter.dev/docs/development/accessibility-and-localization/internationalization
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:graphql_flutter/graphql_flutter.dart';

/// Utils
import 'package:planifago/utils/constants.dart';
import 'package:planifago/globals.dart' as globals;

/// Router
import 'package:planifago/router.dart' as router;
import 'package:planifago/utils/utils.dart';

final graphqlEndpoint = ConstantApi.devApiAddress + '/api/graphql';

void main() async {
  await initHiveForFlutter();
  await DotEnv.load();

  final HttpLink httpLink = HttpLink(graphqlEndpoint);

  final AuthLink authLink = AuthLink(
    getToken: () async {
      final token = await JwtUtils.getAccessToken;
      return 'Bearer $token';
    },
  );

  final dynamic appDefaultLanguage =
      await StorageUtils.get('settings', 'language');
  final Locale appDefaultLocale = Locale(appDefaultLanguage ?? 'en');

  // TIPS - save language
  // StorageUtils.save('settings', 'language', 'fr');

  /// Check if user was already connected to app
  /// And
  /// AccessToken is valid
  final FutureOr<String> userBearer = await authLink.getToken();
  if (userBearer.toString().length <= 28) {
    /// If access token not contain JWT
    globals.userIsConnected = false;
  } else {
    globals.userIsConnected = true;
  }

  final Link link = authLink.concat(httpLink);
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(Main(client, appDefaultLocale));
}

class Main extends StatelessWidget {
  Main(this.client, this._locale);

  final ValueNotifier<GraphQLClient> client;
  final Locale _locale;

  get _supportedLocales {
    List<Locale> locales = [];
    ConstantLanguage.languages.forEach((element) {
      locales.add(Locale(element, ''));
    });

    return locales;
  }

  @override
  Widget build(Object context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        localizationsDelegates: [
          // uncomment the line below after codegen
          /// https://flutter.dev/docs/development/accessibility-and-localization/internationalization
          AppLocalizations.delegate,

          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: _supportedLocales,
        title: 'Planifago',
        locale: _locale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: Text('home'),
        initialRoute: '/',
        onGenerateRoute: (page) {
          return router.routes(context, page);
        },
      ),
    );
  }
}
