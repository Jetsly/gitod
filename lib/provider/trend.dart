import 'package:gitod/models/language.dart';
import 'package:gitod/models/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

const String baseUrl = 'https://github-trending-api.now.sh';

class TrendModel with ChangeNotifier {
  final http.Client _client = http.Client();

  TrendType type;
  String lang;

  List<Language> languages = [];
  List<TrendRepository> repositories = [];

  String _storeData({TrendType trendType, String language}) {
    type = trendType;
    lang = language;
    return type == TrendType.daily
        ? 'daily'
        : type == TrendType.weekly ? 'weekly' : 'monthly';
  }

  void fetchInit() async {
    await fetchLanguage();
    await fetchRepositories();
  }

  Future<void> fetchLanguage() async {
    var response = await _client.get("$baseUrl/languages");
    List responseJson = json.decode(response.body);
    languages = responseJson.map((m) => Language.fromJson(m)).toList();
  }

  Future<void> fetchRepositories(
      {TrendType trendType = TrendType.daily, String language = ''}) async {
    if (repositories.isNotEmpty) {
      repositories = [];
      notifyListeners();
    }
    var since = _storeData(trendType: trendType);
    print("$baseUrl/repositories?since=$since&language=$language");
    var response = await _client
        .get("$baseUrl/repositories?since=$since&language=$language");
    List responseJson = json.decode(response.body);
    repositories =
        responseJson.map((m) => TrendRepository.fromJson(m)).toList();
    notifyListeners();
  }
}
