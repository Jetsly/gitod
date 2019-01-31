import 'package:flutter/material.dart';
import 'package:gitod/src/models/types.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/widget/list_repo.dart';
import 'package:gitod/src/widget/query_graphql.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String viewStar = """
{
  viewer {
    starredRepositories(first: 20, orderBy: {field: STARRED_AT, direction: DESC}) {
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
        return Center(
            child: SpinKitCubeGrid(
          color: Theme.of(context).primaryColor,
          size: 50.0,
        ));
      }
      RepositoryConnection repositories =
          RepositoryConnection.fromJson(data['viewer']['starredRepositories']);
      return ListRepoWidget(repositories: repositories.edges);
    });
  }
}
