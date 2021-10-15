import 'dart:convert';
import 'dart:html';

import 'package:firebase/firebase.dart' as fb;

import 'model/article.dart';
import 'model/article_category.dart';
import 'model/tag.dart';

class ArticleListManager {
  static ArticleListManager? _instance;

  List<Article> _articleList = [];
  Map<String, dynamic> _categoryData = {};

  ArticleListManager._internal();

  factory ArticleListManager() {
    _instance ??= ArticleListManager._internal();
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
    _categoryData = Map<String, dynamic>.from(categoryDataJson);
  }

  Map<String, dynamic> _getCategoryChildren(ArticleCategory category,
      {Map? categoryData}) {
    var data = categoryData ?? _categoryData;

    var result = <String, dynamic>{};
    data.forEach((categoryName, value) {
      if (categoryName == category.text) {
        return value;
      }

      result = _getCategoryChildren(category, categoryData: data[categoryName]);
      if (result.isNotEmpty) {
        return;
      }
    });

    return result;
  }

  List<ArticleCategory> _arrangeCategoryChildren(
      Map<String, dynamic> data, List<ArticleCategory> result) {
    data.forEach((categoryName, value) {
      result.add(ArticleCategory(categoryName));
      result.addAll(_arrangeCategoryChildren(value, result));
    });

    return result;
  }

  List<Article> find(List<Tag> tags, ArticleCategory? category) {
    //タグが一致する記事
    var articles = tags.isEmpty
        ? _articleList
        : _articleList.where((element) => element.hasTag(tags)).toList();

    if (category == null) return articles;

    var articleCategoryChildren =
        _arrangeCategoryChildren(_getCategoryChildren(category), []);
    //カテゴリと一致するものだけをとりだす
    var result = <Article>[];
    for (var i = 0; i < articles.length; i++) {
      var article = articles[i];
      if (articleCategoryChildren.contains(article.category)) {
        result.add(article);
      }
    }

    return result;
  }

  Map<String, dynamic> getCategoryData() {
    return _categoryData;
  }
}
