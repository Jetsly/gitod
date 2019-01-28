import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class User {
  String id;
  String login;
  String name;
  String avatarUrl;
  User.fromJson(Map json) {
    if (json != null && json.isNotEmpty) {
      id = json['id'];
      login = json['login'];
      name = json['name'];
      avatarUrl = json['avatarUrl'];
    }
  }
}

class Owner extends User {
  Owner.fromJson(Map json) : super.fromJson(json);
}

class Language {
  String id;
  String color;
  String name;

  Language.fromJson(Map json) {
    if (json != null && json.isNotEmpty) {
      id = json['id'];
      color = json['color'];
      name = json['name'];
    }
  }
}

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

class PageInfo {
  bool hasNextPage;
  bool hasPreviousPage;
  String startCursor;

  PageInfo.fromJson(Map json) {
    if (json != null && json.isNotEmpty) {
      hasNextPage = json['hasNextPage'];
      hasPreviousPage = json['hasPreviousPage'];
      startCursor = json['startCursor'];
    }
  }
}

class RepositoryEdge {
  String cursor;
  Repository node;

  RepositoryEdge.fromJson(Map json) {
    cursor = json['cursor'];
    node = Repository.fromJson(json['node']);
  }
}

class StargazerEdge {
  String cursor;
  User node;
  DateTime starredAt;

  StargazerEdge.fromJson(Map json) {
    cursor = json['cursor'];
    starredAt = json['starredAt'];
    node = User.fromJson(json['node']);
  }
}

// class Connection<T> {
//   PageInfo pageInfo;
//   List<T> edges;
//   Connection<T>.fromJson(Map json) {
//     pageInfo = PageInfo.fromJson(json['pageInfo']);
//     edges = new List();
//     for (dynamic edge in json['edges']) {
//       edges.add(this.fromJson(edge));
//     }
//   }
// }

class RepositoryConnection {
  PageInfo pageInfo;
  List<RepositoryEdge> edges;
  RepositoryConnection.fromJson(Map json) {
    pageInfo = PageInfo.fromJson(json['pageInfo']);
    edges = new List();
    for (dynamic edge in json['edges']) {
      edges.add(RepositoryEdge.fromJson(edge));
    }
  }
}

class StargazerConnection {
  PageInfo pageInfo;
  List<StargazerEdge> edges;
  StargazerConnection.fromJson(Map json) {
    pageInfo = PageInfo.fromJson(json['pageInfo']);
    edges = new List();
    for (dynamic edge in json['edges']) {
      edges.add(StargazerEdge.fromJson(edge));
    }
  }
}
