import 'package:flutter/material.dart';
import 'package:gitod/src/models/types.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/widget/repo.dart';

String viewStar = """
query {
  viewer {
    starredRepositories(first: 10, orderBy: {field: STARRED_AT, direction: DESC}) {
      totalCount
      ${RepositoryEdge.graph}
      ${PageInfo.graph}
    }
  }
}
""";

class HomeStar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepoWidget(
      query: viewStar,
    );
  }
}
