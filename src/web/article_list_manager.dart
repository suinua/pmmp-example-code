import 'dart:convert';
import 'dart:html';

import 'package:firebase/firebase.dart' as fb;

import 'web_article.dart';
import 'web_article_category.dart';
import 'web_tag.dart';

class ArticleListManager {
  static ArticleListManager? _instance;

  List<WebArticle> _articleList = [];

  ArticleListManager._internal();

  factory ArticleListManager() {
    _instance ??= ArticleListManager._internal();
    return _instance!;
  }

  Future<void> init() {
    return _fetchArticleData();
  }

  Future<void> _fetchArticleData() async {
    fb.initializeApp(
        apiKey: 'AIzaSyC0vZgbSMWa9QWYFAGyvavzOqhCa9dKpxs',
        authDomain: '',
        databaseURL: '',
        projectId: 'pmmp-example-code',
        storageBucket: 'pmmp-example-code.appspot.com');

    var storage = fb.storage();
    var value = await storage.ref('data.json').getDownloadURL();
    var request = await HttpRequest.request(Uri.decodeFull(value.toString()));

    var json = jsonDecode(request.response);

    var result = <WebArticle>[];
    json.forEach((_, data) {
      result.add(WebArticle.fromJson(Map<String, dynamic>.from(data)));
    });

    _articleList = result;
  }

  List<WebArticle> findByTags(List<WebTag> tags) {
    return _articleList.where((element) => element.hasWebTag(tags)).toList();
  }

  List<WebArticle> findByCategory(DefinedArticleCategory DefineCategory) {
    var category = DefineCategory.toWebArticleCategory();

    var result = <WebArticle>[];
    for (var i = 0; i < _articleList.length; i++) {
      var article = _articleList[i];

      if (article.category == category) {
        result.add(article);
      } else if (article.category.parents.contains(category)) {
        result.add(article);
      }
    }

    return result;
  }
}
