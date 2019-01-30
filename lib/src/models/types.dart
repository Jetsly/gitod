String val(String value) {
  return value != null ? value : '';
}

class User {
  static String graph = """
    id
    name
    login
    avatarUrl
    email
    location
    websiteUrl
    bio
  """;
  String id;
  String name;
  String login;
  String email;
  String location;
  String avatarUrl;
  String websiteUrl;
  String bio;
  User.fromJson(Map json) {
    if (json != null && json.isNotEmpty) {
      id = val(json['id']);
      login = val(json['login']);
      name = val(json['name']);
      email = val(json['email']);
      location = val(json['location']);
      avatarUrl = val(json['avatarUrl']);
      websiteUrl = val(json['websiteUrl']);
      bio = val(json['bio']);
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
      id = val(json['id']);
      color = val(json['color']);
      name = val(json['name']);
    }
  }
}

class PageInfo {
  static String graph =
      "pageInfo { hasNextPage hasPreviousPage startCursor  endCursor }";

  bool hasNextPage;
  bool hasPreviousPage;
  String startCursor;
  String endCursor;

  PageInfo.fromJson(Map json) {
    if (json != null && json.isNotEmpty) {
      hasNextPage = json['hasNextPage'];
      hasPreviousPage = json['hasPreviousPage'];
      startCursor = json['startCursor'];
      endCursor = json['endCursor'];
    }
  }
}

abstract class Connection<T> {
  PageInfo pageInfo;
  num totalCount;
  List<T> edges;
  String get count {
    if (this.totalCount > 1000) {
      return "${(this.totalCount / 1000).toStringAsFixed(1)}k";
    }
    return this.totalCount.toString();
  }

  T formNodeJson(dynamic edge);

  Connection.fromJson(Map json) : totalCount = json['totalCount'] {
    pageInfo = PageInfo.fromJson(json['pageInfo']);
    List<dynamic> edgesMap = json['edges'];
    if (edgesMap != null && edgesMap.isNotEmpty) {
      edges = edgesMap.map(formNodeJson).toList();
    }
  }
}

class Edge<T> {
  String cursor;
  T node;
  Edge.fromJson(Map json) : cursor = json['cursor'];
}
