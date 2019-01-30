import 'package:flutter/material.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/models/utils.dart';
import 'package:gitod/src/widget/query_graphql.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListRepoWidget extends StatefulWidget {
  final String query;
  const ListRepoWidget({@required this.query});

  @override
  State<StatefulWidget> createState() => _ListRepoWidgetState();
}

class _ListRepoWidgetState extends State<ListRepoWidget> {
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
          'Loading Repo',
        );
      }
      Map viewer = data['viewer'];
      RepositoryConnection repositories = RepositoryConnection.fromJson(
          viewer.containsKey('repositories')
              ? viewer['repositories']
              : viewer['starredRepositories']);
      final itemCount = repositories.edges.length;
      return ListView.separated(
          itemCount: itemCount,
          separatorBuilder: (BuildContext context, int index) => Divider(
                height: 2.5,
                color: HexColor("#eaecef"),
              ),
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
                      padding: EdgeInsets.fromLTRB(2, 0, 0, 8),
                      alignment: Alignment.centerLeft,
                      child: Text(node.description,
                          overflow: TextOverflow.ellipsis, maxLines: 3)));
            }
            return Container(
              color: node.isPrivate ? HexColor("#fffdef") : null,
              child: ListTile(
                contentPadding: EdgeInsets.all(6),
                onTap: () {},
                title: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(
                          node.isPrivate
                              ? "assets/repo-lock.svg"
                              : "assets/repo.svg",
                          width: 13,
                          color: HexColor("#586069")),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(node.nameWithOwner,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                              )))
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    children: subtitle,
                  ),
                ),
              ),
            );
          });
    });
  }
}
