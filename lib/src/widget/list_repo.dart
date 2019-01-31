import 'package:flutter/material.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/models/utils.dart';
import 'package:gitod/src/screen/repo_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListRepoWidget extends StatelessWidget {
  final List<RepositoryEdge> repositories;
  const ListRepoWidget({@required this.repositories});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: repositories.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 2.5,
              color: HexColor("#eaecef"),
            ),
        itemBuilder: (BuildContext context, int index) {
          Repository node = repositories[index].node;
          final subtitle = <Widget>[
            Row(children: () {
              final subRow = <Widget>[
                Icon(Icons.star, size: 18, color: HexColor("#586069")),
                Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                    child: Text(node.stargazers.count,
                        style: TextStyle(color: HexColor("#586069")))),
              ];
              if (node.primaryLanguage.id != null &&
                  node.primaryLanguage.color.isNotEmpty) {
                subRow.insertAll(0, [
                  Icon(Icons.lens,
                      size: 15, color: HexColor(node.primaryLanguage.color)),
                  Padding(
                      padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                      child: Text(node.primaryLanguage.name,
                          style: TextStyle(color: HexColor("#586069"))))
                ]);
              }
              return subRow;
            }())
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
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<String>(
                    builder: (context) => RepoScreen()));
              },
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
  }
}
