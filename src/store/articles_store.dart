import 'dart:convert';
import 'dart:html';

import 'package:firebase/firebase.dart' as fb;

import '../model/article.dart';

class ArticlesStore {
  static ArticlesStore? _instance;

  List<Article> _articleList = [];
  Map<String, dynamic> _categoriesData = {};

  ArticlesStore._internal();

  factory ArticlesStore() {
    _instance ??= ArticlesStore._internal();
    return _instance!;
  }

  Future<void> init() {
    return _fetchData();
  }

  Future<void> _fetchData() async {
    fb.initializeApp(
        apiKey: 'AIzaSyC0vZgbSMWa9QWYFAGyvavzOqhCa9dKpxs',
        authDomain: '',
        databaseURL: '',
        projectId: 'pmmp-example-code',
        storageBucket: 'pmmp-example-code.appspot.com');

    var storage = fb.storage();

    //article
    var articleDataDownloadURL =
    await storage.ref('data.json').getDownloadURL();
    var articleDataGetRequest = await HttpRequest.request(
        Uri.decodeFull(articleDataDownloadURL.toString()));
    var articleDataJson = jsonDecode(articleDataGetRequest.response);

    var articleListResult = <Article>[];
    articleDataJson.forEach((_, data) {
      articleListResult.add(Article.fromJson(Map<String, dynamic>.from(data)));
    });
    _articleList = articleListResult;

    //category
    var categoryDataDownloadURL =
    await storage.ref('category.json').getDownloadURL();
    var categoryDataGetRequest = await HttpRequest.request(
        Uri.decodeFull(categoryDataDownloadURL.toString()));
    var categoryDataJson = jsonDecode(categoryDataGetRequest.response);
    _categoriesData = Map<String, dynamic>.from(categoryDataJson);
  }

  List<Article> getArticles() {
    return _articleList;
  }

  Map<String, dynamic> getCategoryData() {
    return _categoriesData;
  }
}
