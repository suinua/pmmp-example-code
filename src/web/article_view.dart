import 'dart:html';

import '../article.dart';

HtmlElement articleToHtml(Article article) {
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

HtmlElement tagToHtml(Tag tag) {
  return DivElement()
    ..text = tag.text
    ..className = 'tag';
}