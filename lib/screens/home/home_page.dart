/// Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// Api
import 'package:planifago/api/model/events.dart';
import 'package:planifago/utils/constants.dart';

// Utils / Constants
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
          child: Query(
              options: QueryOptions(
                document: gql(Events.publics),
              ),
              builder: (QueryResult result,
                  {VoidCallback refetch, FetchMore fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }

                if (result.isLoading) {
                  return getLoader;
                }

                List publicEvents = result.data['events']['edges'];
                final Map pageInfo = result.data['events']['pageInfo'];
                // ignore: unused_local_variable
                final int totalCount = result.data['events']['totalCount'];
                final String fetchMoreCursor = pageInfo['endCursor'];

                // ignore: unused_local_variable
                FetchMoreOptions opts = FetchMoreOptions(
                  variables: {'cursor': fetchMoreCursor},
                  updateQuery: (previousResultData, fetchMoreResultData) {
                    final List<dynamic> repos = [
                      ...previousResultData['events']['edges'] as List<dynamic>,
                      ...fetchMoreResultData['events']['edges'] as List<dynamic>
                    ];

                    fetchMoreResultData['events']['edges'] = repos;
                    return fetchMoreResultData;
                  },
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 50, 0, 0),
                      child: Text(
                        AppLocalizations.of(context).public_events,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemCount: publicEvents.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(),
                          itemBuilder: (context, index) {
                            final event = publicEvents[index]['node'];

                            return ListTile(
                              title: Text(event['name']),
                              subtitle: Text(event['description']),
                              trailing: SizedBox(
                                height: 50,
                                width: 50,
                                child: Row(children: [
                                  Image.asset('assets/images/users.png'),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text('50'))
                                ]),
                              ),
                            );
                          }),
                    )
                  ],
                );
              })),
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
