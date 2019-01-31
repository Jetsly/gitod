import 'package:flutter/material.dart';
import 'package:gitod/src/models/types.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/widget/list_repo.dart';
import 'package:gitod/src/widget/query_graphql.dart';

String viewRepo = """
{
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
    return QueryGraphql(viewRepo.replaceAll('\n', ' '), builder: ({
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
      return ListRepoWidget(repositories: repositories.edges);
    });
  }
}
