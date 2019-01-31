import 'package:flutter/material.dart';
import 'package:gitod/src/models/types.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/widget/list_follow.dart';
import 'package:gitod/src/widget/query_graphql.dart';


String viewFollowing = """
{
  viewer {
    following(first: 10) {
      ${UserEdge.graph}
      ${PageInfo.graph}
    }
  }
}
""";

class HomeFollowing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QueryGraphql(viewFollowing.replaceAll('\n', ' '), builder: ({
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
      FollowerConnection follower =
          FollowerConnection.fromJson(data['viewer']['following']);
      return ListFollowWidget(followers: follower.edges);
    });
  }
}
