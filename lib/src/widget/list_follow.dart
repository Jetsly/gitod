import 'package:flutter/material.dart';
import 'package:gitod/src/models/types.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/models/utils.dart';

class ListFollowWidget extends StatelessWidget {
  final List<UserEdge> followers;
  const ListFollowWidget({@required this.followers});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: followers.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 2.5,
              color: HexColor("#eaecef"),
            ),
        itemBuilder: (BuildContext context, int index) {
          User node = followers[index].node;
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
  }
}
