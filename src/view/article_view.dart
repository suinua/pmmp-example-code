import 'dart:html';

import '../model/article.dart';

class ArticleView {
  static HtmlElement convert(Article article) {
    var articleElement = AnchorElement(href: article.url)..className = 'article';
    var titleElement = DivElement()
      ..className = 'title'
      ..text = article.title;
    var conciseBodyElement = DivElement()
      ..className = 'concise-body'
      ..text = article.body;

    articleElement.children.addAll([titleElement, conciseBodyElement]);

    return articleElement;
  }
}