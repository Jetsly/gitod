import 'package:flutter/material.dart';
import 'package:gitod/src/models/types.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/widget/repo.dart';

String viewRepo = """
query {
  viewer {
    repositories(first: 10, orderBy: {field: UPDATED_AT, direction: DESC}) {
      totalCount
      ${RepositoryEdge.graph}
      ${PageInfo.graph}
    }
  }
}
""";

class HomeRepo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepoWidget(
      query: viewRepo,
    );
  }
}
