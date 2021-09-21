import 'dart:convert';
import 'dart:html';

import 'package:firebase/firebase.dart' as fb;

import '../article.dart';
import 'article_view.dart';

List<Article> _articleList = [];

void main() {
  _fetchArticleData().then((_v) {
    _insertTags();

    var tagElements = querySelectorAll('.tag');
    tagElements.forEach((element) {
      element.onClick.listen((event) {
        print(element.text);
        var tag = Tag(element.text);
        _displayArticleThumbnails(_findArticleByTags([tag]));
      });
    });
  });
}

void _displayArticleThumbnails(List<Article> articles) {
  var articleListElement = querySelector('.article-list');
  articleListElement!.children = [];
  articleListElement.children
      .addAll(articles.map((e) => articleToHtml(e)).toList());
}

//todo:リーダブル
List<Article> _findArticleByTags(List<Tag> tags) {
  var result = <Article>[];
  _articleList.forEach((markdownFileData) {
    var isTarget = false;
    tags.forEach((tag) {
      if (markdownFileData.tags.contains(tag)) isTarget = true;
    });

    if (isTarget) result.add(markdownFileData);
  });

  return result;
}

void _insertTags() {
  var element = querySelector('.tag-list');
  assert(element != null);

  Tag.defaultTags.forEach((Tag tag) {
    element!.children.add(tagToHtml(tag));
  });
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
  json.forEach((_k, data) {
    result.add(Article.fromJson(Map<String,dynamic>.from(data)));
  });

  _articleList = result;
}
