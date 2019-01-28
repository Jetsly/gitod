import 'package:flutter/material.dart';
import 'package:gitod/src/widget/git_repo.dart';

String readViewStar = """
query {
  viewer {
    starredRepositories(first: 10, orderBy: {field: STARRED_AT, direction: DESC}) {
      totalCount
      edges {
        cursor
        node {
          ... on Repository {
            owner {
              id
              login
              avatarUrl
            }
            id
            name
            nameWithOwner
            description
            isPrivate
            forkCount
            primaryLanguage {
              id
              color
              name
            }
            stargazers(first: 0) {
              totalCount
            }
          }
        }
      }
      pageInfo {
        hasNextPage
        hasPreviousPage
        startCursor
      }
    }
  }
}
"""
    .replaceAll('\n', ' ');

class HomeStar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepoWidget(
      query: readViewStar,
    );
  }
}
