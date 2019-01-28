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
