import 'dart:convert';
import 'dart:html';

import 'package:firebase/firebase.dart' as fb;

import 'model/article.dart';
import 'model/article_category.dart';
import 'model/tag.dart';

class ArticleListManager {
  static ArticleListManager? _instance;

  List<Article> _articleList = [];

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

    var result = <Article>[];
    json.forEach((_, data) {
      result.add(Article.fromJson(Map<String, dynamic>.from(data)));
    });

    _articleList = result;
  }

  List<Article> find(List<Tag> tags, DefinedArticleCategory? defineCategory) {
    //タグが一致する記事
    var articles = tags.isEmpty ? _articleList : _articleList.where((element) => element.hasWebTag(tags)).toList();

    if (defineCategory == null) {
      return articles;
    }

    //カテゴリと一致するものだけをとりだす
    var category = defineCategory.toArticleCategory();
    var result = <Article>[];
    for (var i = 0; i < articles.length; i++) {
      var article = articles[i];

      if (article.category == category) {
        result.add(article);
      } else if (article.category.parents.contains(category)) {
        result.add(article);
      }
    }

    return result;
  }
}
