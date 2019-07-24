class Repository {
  String author;
  String name;
  String avatar;

  String url;
  String description;
  String language;
  String languageColor;

  int stars;
  int forks;

  Repository.fromJson(Map json) {
    author = json['author'];
    name = json['name'];
    avatar = json['avatar'];

    url = json['url'];
    description = json['description'];
    language = json['language'];
    languageColor = json['languageColor'];

    stars = json['stars'];
    forks = json['forks'];
  }
}
