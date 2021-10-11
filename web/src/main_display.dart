import 'dart:html';

import 'web_article.dart';

void showArticleThumbnails(List<WebArticle> articles) {
  var articleListElement = querySelector('.article-list');
  articleListElement!.children = [];
  articleListElement.children
      .addAll(articles.map((e) => e.toHtmlElement()).toList());
}