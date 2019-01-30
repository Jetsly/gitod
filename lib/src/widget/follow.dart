import 'package:flutter/material.dart';
import 'package:gitod/src/models/types.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/models/utils.dart';
import 'package:gitod/src/widget/query-graphql.dart';

class FollowWidget extends StatefulWidget {
  final String query;
  const FollowWidget({@required this.query});

  @override
  State<StatefulWidget> createState() => _FollowWidgetState();
}

class _FollowWidgetState extends State<FollowWidget> {
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
      return ListView.builder(
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            User node = follower.edges[index].node;
            final subtitle = <Widget>[];
            if (node.bio.isNotEmpty) {
              subtitle.add(Text(node.bio));
            }
            final listItem = <Widget>[
              ListTile(
                contentPadding: EdgeInsets.all(6),
                onTap: () {},
                leading: ClipOval(
                  child: Image.network(node.avatarUrl),
                ),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Row(
                    children: <Widget>[
                      Text(node.login,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          )),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child:
                              Text(node.name.isEmpty ? node.login : node.name,
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
              ),
            ];
            if (index != itemCount - 1) {
              listItem.add(Divider(
                height: 2.5,
                color: HexColor("#eaecef"),
              ));
            }
            return Container(child: Column(children: listItem));
          });
    });
  }
}
