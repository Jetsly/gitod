import 'package:gitod/models/language.dart';
import 'package:gitod/models/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

const String baseUrl = 'https://github-trending-api.now.sh';

class TrendModel with ChangeNotifier {
  var _init = false;
  final http.Client _client = http.Client();

  List<Language> languages = [];
  Map<TrendType, List<TrendRepository>> repositories = {};

  void fetchInit() async {
    if (!_init) {
      _init = true;
      fetchLanguage().then((v) => fetchAllRepositories());
    }
  }

  Future<void> fetchLanguage() async {
    var response = await _client.get("$baseUrl/languages");
    List responseJson = json.decode(response.body);
    languages = responseJson.map((m) => Language.fromJson(m)).toList();
  }

  Future<void> fetchAllRepositories({String language = ''}) async {
    fetchRepositories(TrendType.daily, language);
    fetchRepositories(TrendType.monthly, language);
    fetchRepositories(TrendType.weekly, language);
  }

  Future<void> fetchRepositories(TrendType trendType, String language) async {
    var since = trendType == TrendType.daily
        ? 'daily'
        : trendType == TrendType.weekly ? 'weekly' : 'monthly';
    if (repositories.isNotEmpty) {
      repositories[trendType] = null;
      notifyListeners();
    }
    var url = "$baseUrl/repositories?since=$since&language=$language";
    var response = await _client.get(url);
    List responseJson = json.decode(response.body);
    repositories[trendType] =
        responseJson.map((m) => TrendRepository.fromJson(m)).toList();
    notifyListeners();
  }
}
