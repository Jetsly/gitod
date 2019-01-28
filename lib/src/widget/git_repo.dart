import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:gitod/src/models/repo.dart';

String readRepositories = """
query {
  viewer {
    repositories(first: 10, orderBy: {field: UPDATED_AT, direction: DESC}) {
      edges {
        cursor
        node {
          ... on Repository {
            owner {
              id
              login
              avatarUrl
            }
            id
            name
            nameWithOwner
            description
            isPrivate
            forkCount
            primaryLanguage {
              id
              color
              name
            }
            stargazers(first: 100) {
              edges {
                node {
                  ... on User {
                    name
                  }
                }
              }
            }
          }
        }
      }
      pageInfo {
        hasNextPage
        hasPreviousPage
        startCursor
      }
    }
  }
}
"""
    .replaceAll('\n', ' ');

class RepoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RepoWidgetState();
}

class _RepoWidgetState extends State<RepoWidget> {
  @override
  Widget build(BuildContext context) {
    return Query(readRepositories, // this is the query you just created
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
      RepositoryConnection repositories =
          RepositoryConnection.fromJson(data['viewer']['repositories']);
      final itemCount = repositories.edges.length;
      return ListView.builder(
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            Repository node = repositories.edges[index].node;
            final subtitle = <Widget>[
              Row(children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Icon(Icons.star, size: 18, color: Colors.black)),
                Text(node.stargazers.edges.length.toString()),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                    child: Icon(Icons.lens,
                        size: 15, color: HexColor(node.primaryLanguage.color))),
                Text(node.primaryLanguage.name),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                    child: Icon(Icons.share, size: 15, color: Colors.black)),
                Text(node.forkCount.toString()),
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
