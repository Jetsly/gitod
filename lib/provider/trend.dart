import 'package:gitod/models/language.dart';
import 'package:gitod/models/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

const String baseUrl = 'https://github-trending-api.now.sh';

enum Since { daily, weekly, monthly }

class TrendModel with ChangeNotifier {
  final http.Client client = http.Client();

  List<Language> languages = [];
  List<Repository> repositories = [];

  void fetchLanguage() async {
    if (languages.isEmpty) {
      var response = await client.get("$baseUrl/languages");
      List responseJson = json.decode(response.body);
      languages = responseJson.map((m) => Language.fromJson(m)).toList();
      notifyListeners();
    }
  }

  void fetchRepositories({@required Since since, String language = ''}) async {
    var _since = since == Since.daily
        ? 'daily'
        : since == Since.weekly ? 'weekly' : 'monthly';
    print("$baseUrl/repositories?since=$_since&language=$language");
    var response = await client
        .get("$baseUrl/repositories?since=$_since&language=$language");
    List responseJson = json.decode(response.body);
    repositories = responseJson.map((m) => Repository.fromJson(m)).toList();
    notifyListeners();
  }

  // void increment() {
  //   _count++;
  //   notifyListeners();
  // }
}
