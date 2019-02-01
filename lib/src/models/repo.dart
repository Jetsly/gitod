import 'package:gitod/src/models/types.dart';

class Repository {
  String id;
  String name;
  String nameWithOwner;
  String description;
  num forkCount;
  bool isPrivate;
  Owner owner;
  Language primaryLanguage;
  StargazerConnection stargazers;
  Ref defaultBranchRef;
  GitObject object;

  Repository.fromJson(Map json) : id = json['id'] {
    name = json['name'];
    nameWithOwner = json['nameWithOwner'];
    forkCount = json['forkCount'];
    isPrivate = json['isPrivate'];
    description = json['description'] == null ? '' : json['description'];
    owner = Owner.fromJson(json['owner']);
    primaryLanguage = Language.fromJson(json['primaryLanguage']);
    stargazers = StargazerConnection.fromJson(json['stargazers']);
    defaultBranchRef = Ref.fromJson(json['defaultBranchRef']);
    object = GitObject.fromJson(json['object']);
  }
}

class RepositoryEdge extends Edge<Repository> {
  static String graph = """
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
  }""";
  RepositoryEdge.fromJson(Map json) : super.fromJson(json) {
    node = Repository.fromJson(json['node']);
  }
}

class StargazerEdge extends Edge<User> {
  DateTime starredAt;
  StargazerEdge.fromJson(Map json) : super.fromJson(json) {
    starredAt = json['starredAt'];
    node = User.fromJson(json['node']);
  }
}

class UserEdge extends Edge<User> {
  static String graph = """
  edges {
    node {
      ${User.graph}
    }
  }""";
  UserEdge.fromJson(Map json) : super.fromJson(json) {
    node = User.fromJson(json['node']);
  }
}

class SearchResultItemEdge extends RepositoryEdge {
  SearchResultItemEdge.fromJson(Map json) : super.fromJson(json);
}

class RepositoryConnection extends Connection<RepositoryEdge> {
  formNodeJson(edge) => RepositoryEdge.fromJson(edge);

  RepositoryConnection.fromJson(Map json) : super.fromJson(json);
}

class StargazerConnection extends Connection<StargazerEdge> {
  formNodeJson(edge) => StargazerEdge.fromJson(edge);

  StargazerConnection.fromJson(Map json) : super.fromJson(json);
}

class FollowerConnection extends Connection<UserEdge> {
  formNodeJson(edge) => UserEdge.fromJson(edge);

  FollowerConnection.fromJson(Map json) : super.fromJson(json);
}

class SearchResultItemConnection extends Connection<SearchResultItemEdge> {
  num repositoryCount;
  num userCount;
  num issueCount;
  num wikiCount;

  formNodeJson(edge) => SearchResultItemEdge.fromJson(edge);

  SearchResultItemConnection.fromJson(Map json) : super.fromJson(json) {
    repositoryCount = json['repositoryCount'];
    userCount = json['userCount'];
    issueCount = json['issueCount'];
    wikiCount = json['wikiCount'];
  }
}
