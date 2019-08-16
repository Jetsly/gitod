import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gitod/models/repository.dart';
import 'package:gitod/models/utils.dart';
import 'package:transparent_image/transparent_image.dart';

var color = HexColor("#586069");

class ListTrendWidget extends StatelessWidget {
  final List<TrendRepository> repositories;
  const ListTrendWidget({@required this.repositories});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: repositories.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 4,
              color: HexColor("#e1e4e8"),
            ),
        itemBuilder: (BuildContext context, int index) {
          TrendRepository node = repositories[index];
          var hasLang =
              node.languageColor.isNotEmpty && node.language.isNotEmpty;
          return Container(
            color: null,
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 10, 5, 5),
              onTap: () {},
              title: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset("assets/repo.svg",
                        width: 13, color: color),
                    Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(node.author + " / " + node.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#0366d6")))),
                  ],
                ),
              ),
              subtitle: Column(
                children: <Widget>[
                  ...node.description.length > 0
                      ? [
                          Container(
                              padding: EdgeInsets.fromLTRB(2, 0, 0, 8),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                node.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  color: color,
                                ),
                              ))
                        ]
                      : [],
                  Row(children: () {
                    return <Widget>[
                      ...hasLang
                          ? [
                              Icon(Icons.lens,
                                  size: 15,
                                  color: HexColor(node.languageColor)),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                                  child: Text(node.language,
                                      style: TextStyle(color: color)))
                            ]
                          : [],
                      Icon(Icons.star, size: 18, color: color),
                      Padding(
                          padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                          child: Text(formatText(node.stars.toString()),
                              style: TextStyle(color: color))),
                      SvgPicture.asset("assets/fork.svg",
                          width: 10, color: color),
                      Padding(
                          padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                          child: Text(formatText(node.forks.toString()),
                              style: TextStyle(color: color))),
                    ];
                  }()),
                  Container(
                    padding: EdgeInsets.fromLTRB(2, 10, 0, 0),
                    height: 35,
                    child: Row(children: () {
                      return node.builtBys
                          .map((user) => Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: ClipRRect(
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(5.0)),
                                child: FadeInImage.memoryNetwork(
                                  width: 25,
                                  image: user.avatar,
                                  placeholder: kTransparentImage,
                                ),
                              )))
                          .toList();
                    }()),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
