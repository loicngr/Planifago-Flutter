# planifago

Planifago application

## Help Links
 - API : https://github.com/loicngr/Planifago-API
 - https://flutter.dev/docs/cookbook
 - https://github.com/zino-app/graphql-flutter
 - https://github.com/zino-app/graphql-flutter/tree/master/packages/graphql
 - https://flutter.dev/docs/development/accessibility-and-localization/internationalization
 
## Configuration Env
 - ``.env`` (at root directory)
    - API_LOCAL_IP='127.0.0.1'

## Execute a function 
   - ```dart
   /// r = null or Future<Response>
   var r = await RequestUtils.tryCatchRequest(appContext, myFunction, [param1, param2]);
   ```

## Add new locale
   - Update List `ConstantLanguage.languages` in `lib/utils/constants.dart`
   - Update function `LanguageUtils.getLanguages` in `lib/utils/utils.dart`
