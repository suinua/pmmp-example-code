import 'dart:convert';
import 'dart:html';

import 'package:firebase/firebase.dart' as fb;

import 'web_article.dart';

class ArticleListManager {
  List<WebArticle> _articleList = [];

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
    json.forEach((_k, data) {
      result.add(WebArticle.fromJson(Map<String, dynamic>.from(data)));
    });

    _articleList = result;
  }

//todo:リーダブル
  List<WebArticle> findByTags(List<WebTag> tags) {
    return _articleList.where((element) => element.hasWebTag(tags)).toList();
  }
}
