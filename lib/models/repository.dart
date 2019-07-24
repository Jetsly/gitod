enum TrendType { daily, weekly, monthly }


class TrendUser {
  String href;
  String avatar;
  String username;

  TrendUser.fromJson(Map json) {
    href = json['href'];
    avatar = json['avatar'];
    username = json['username'];
  }
}

class TrendRepository {
  String author;
  String name;
  String avatar;

  String url;
  String description;
  String language;
  String languageColor;

  int stars;
  int forks;
  int currentPeriodStars;

  List<TrendUser> builtBys;

  TrendRepository.fromJson(Map json) {
    author = json['author'];
    name = json['name'];
    avatar = json['avatar'];

    url = json['url'];
    description = json['description'];
    language = json['language'];
    languageColor = json['languageColor'];

    stars = json['stars'];
    forks = json['forks'];
    currentPeriodStars = json['currentPeriodStars'];
    List<dynamic> builtBy = json['builtBy'];
    if (builtBy != null && builtBy.isNotEmpty) {
      builtBys = builtBy.map((m) => TrendUser.fromJson(m)).toList();
    } else {
      builtBys = [];
    }
  }
}
