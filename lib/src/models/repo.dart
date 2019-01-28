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

  Repository.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    nameWithOwner = json['nameWithOwner'];
    forkCount = json['forkCount'];
    isPrivate = json['isPrivate'];
    description = json['description'] == null ? '' : json['description'];
    primaryLanguage = Language.fromJson(json['primaryLanguage']);
    stargazers = StargazerConnection.fromJson(json['stargazers']);
    owner = Owner.fromJson(json['owner']);
  }
}

class Edge<T> {
  String cursor;
  T node;
  Edge.fromJson(Map json) {
    cursor = json['cursor'];
  }
}

class RepositoryEdge extends Edge<Repository> {
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

class Connection<T> {
  PageInfo pageInfo;
  List<T> edges;
  Connection.fromJson(Map json) {
    pageInfo = PageInfo.fromJson(json['pageInfo']);
    edges = new List();
  }
}

class RepositoryConnection extends Connection<RepositoryEdge> {
  RepositoryConnection.fromJson(Map json) : super.fromJson(json) {
    for (dynamic edge in json['edges']) {
      edges.add(RepositoryEdge.fromJson(edge));
    }
  }
}

class StargazerConnection extends Connection<StargazerEdge> {
  StargazerConnection.fromJson(Map json) : super.fromJson(json) {
    for (dynamic edge in json['edges']) {
      edges.add(StargazerEdge.fromJson(edge));
    }
  }
}
