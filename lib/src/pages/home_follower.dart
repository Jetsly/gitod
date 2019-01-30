import 'package:flutter/material.dart';
import 'package:gitod/src/models/types.dart';
import 'package:gitod/src/models/repo.dart';
import 'package:gitod/src/widget/follow.dart';

String viewFollower = """
query {
  viewer {
    followers(first: 10) {
      ${UserEdge.graph}
      ${PageInfo.graph}
    }
  }
}
""";

class HomeFollower extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FollowWidget(
      query: viewFollower,
    );
  }
}
