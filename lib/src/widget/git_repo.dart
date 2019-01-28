import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/models/utils.dart';

class RepoWidget extends StatefulWidget {
  final String query;
  const RepoWidget({@required this.query});

  @override
  State<StatefulWidget> createState() => _RepoWidgetState();
}

class _RepoWidgetState extends State<RepoWidget> {
  @override
  Widget build(BuildContext context) {
    return Query(widget.query, // this is the query you just created
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
          'Loading Repo',
        );
      }
      Map viewer = data['viewer'];
      RepositoryConnection repositories = RepositoryConnection.fromJson(
          viewer.containsKey('repositories')
              ? viewer['repositories']
              : viewer['starredRepositories']);
      final itemCount = repositories.edges.length;
      return ListView.builder(
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            Repository node = repositories.edges[index].node;
            final subtitle = <Widget>[
              Row(children: <Widget>[
                Icon(Icons.star, size: 18, color: HexColor("#586069")),
                Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                    child: Text(node.stargazers.count,
                        style: TextStyle(color: HexColor("#586069")))),
                Icon(Icons.lens,
                    size: 15, color: HexColor(node.primaryLanguage.color)),
                Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                    child: Text(node.primaryLanguage.name,
                        style: TextStyle(color: HexColor("#586069")))),
              ])
            ];
            if (node.description.length > 0) {
              subtitle.insert(
                  0,
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      alignment: Alignment.centerLeft,
                      child: Text(node.description,
                          overflow: TextOverflow.ellipsis, maxLines: 3)));
            }
            final listItem = <Widget>[
              ListTile(
                contentPadding: EdgeInsets.all(6),
                onTap: () {},
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Row(
                    children: <Widget>[
                      Icon(
                          node.isPrivate ? Icons.lock_outline : Icons.lock_open,
                          size: 18,
                          color: Colors.lightBlue),
                      Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(node.nameWithOwner,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                              )))
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: subtitle,
                  ),
                ),
              ),
            ];
            if (index != itemCount - 1) {
              listItem.add(Divider(
                height: 2.5,
                color: HexColor("#eaecef"),
              ));
            }
            return Container(
                color: node.isPrivate ? HexColor("#fffdef") : null,
                child: Column(children: listItem));
          });
    });
  }
}
