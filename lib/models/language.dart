class Language {
  String name;
  String urlParam;

  Language.fromJson(Map json) {
    name = json['name'];
    urlParam = json['urlParam'];
  }
}
