import 'package:flutter/material.dart';
import 'package:gitod/src/models/types.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/widget/list_repo.dart';
import 'package:gitod/src/widget/query_graphql.dart';

String viewStar = """
{
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
    return QueryGraphql(viewStar.replaceAll('\n', ' '), builder: ({
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
          RepositoryConnection.fromJson(data['viewer']['starredRepositories']);
      return ListRepoWidget(repositories: repositories.edges);
    });
  }
}
