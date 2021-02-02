# planifago

Planifago application

## Help Links
 - https://flutter.dev/docs/cookbook
 - https://github.com/zino-app/graphql-flutter
 - https://github.com/zino-app/graphql-flutter/tree/master/packages/graphql
 
## Configuration Env
 - ``.env`` (at root directory)
    - API_LOCAL_IP='127.0.0.1'

## Execute a function 
   - ```dart
   /// r = null or Future<Response>
   var r = await RequestUtils.tryCatchRequest(appContext, myFunction, [param1, param2]);
   ```