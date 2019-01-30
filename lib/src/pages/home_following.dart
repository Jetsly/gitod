import 'package:flutter/material.dart';
import 'package:gitod/src/models/types.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/widget/follow.dart';

String viewFollowing = """
query {
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
    return FollowWidget(
      query: viewFollowing,
    );
  }
}
