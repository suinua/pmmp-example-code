import 'dart:html';

import 'web_article_category.dart';
import 'web_tag.dart';

class WebArticle {
  final String url;
  final WebArticleCategory category;
  final List<WebTag> tags;

  final String title;
  final String body;

  WebArticle(
      {required String url,
      required WebArticleCategory category,
      required List<WebTag> tags,
      required String title,
      required String body})
      : url = url,
        category = category,
        title = title,
        tags = tags,
        body = body;

  bool hasWebTag(List<WebTag> objects) {
    for (var i = 0; i < objects.length; i++) {
      if (tags.contains(objects[i])) return true;
    }

    return false;
  }

  WebArticle.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        category = WebArticleCategory(List<String>.from(json['category']['parents']).map((e) => WebArticleCategory([], e)).toList(),json['category']['text']),
        tags = List<String>.from(json['tags'])
            .map((element) => WebTag(element))
            .toList(),
        title = json['title'],
        body = json['body'];

  HtmlElement toHtmlElement() {
    var articleElement = AnchorElement(href: url)..className = 'article';
    var titleElement = DivElement()
      ..className = 'title'
      ..text = title;
    var conciseBodyElement = DivElement()
      ..className = 'concise-body'
      ..text = body;

    articleElement.children.addAll([titleElement, conciseBodyElement]);

    return articleElement;
  }
}
