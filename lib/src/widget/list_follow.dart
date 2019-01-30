import 'package:flutter/material.dart';
import 'package:gitod/src/models/types.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/models/utils.dart';
import 'package:gitod/src/widget/query_graphql.dart';

class ListFollowWidget extends StatefulWidget {
  final String query;
  const ListFollowWidget({@required this.query});

  @override
  State<StatefulWidget> createState() => _ListFollowWidgetState();
}

class _ListFollowWidgetState extends State<ListFollowWidget> {
  @override
  Widget build(BuildContext context) {
    return QueryGraphql(
        widget.query
            .replaceAll('\n', ' '), // this is the query you just created
        builder: ({
      bool loading,
      var data,
      Exception error,
    }) {
      if (error != null) {
        return Text(error.toString());
      }
      if (loading) {
        return Text(
          'Loading Follow',
        );
      }
      Map viewer = data['viewer'];
      FollowerConnection follower = FollowerConnection.fromJson(
          viewer.containsKey('following')
              ? viewer['following']
              : viewer['followers']);
      final itemCount = follower.edges.length;
      return ListView.separated(
          itemCount: itemCount,
          separatorBuilder: (BuildContext context, int index) => Divider(
                height: 2.5,
                color: HexColor("#eaecef"),
              ),
          itemBuilder: (BuildContext context, int index) {
            User node = follower.edges[index].node;
            final subtitle = <Widget>[];
            if (node.bio.isNotEmpty) {
              subtitle.add(Container(
                  alignment: Alignment.centerLeft, child: Text(node.bio.trim())));
            }
            if (node.location.isNotEmpty) {
              subtitle.add(Container(
                  padding: EdgeInsets.only(top: node.bio.isNotEmpty ? 8 : 0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.lightBlue,
                      ),
                      Text(node.location)
                    ],
                  )));
            }
            return Container(
                child: ListTile(
              contentPadding: EdgeInsets.all(10),
              onTap: () {},
              leading: ClipOval(
                child: Image.network(
                  node.avatarUrl,
                  width: 32,
                ),
              ),
              title: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Row(
                  children: <Widget>[
                    Text(node.name.isEmpty ? node.login : node.name,
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: HexColor('#0366d6'))),
                    Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(node.login,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                            )))
                  ],
                ),
              ),
              subtitle: Column(
                children: subtitle,
              ),
            ));
          });
    });
  }
}
