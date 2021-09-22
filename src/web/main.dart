import 'dart:html';

import 'article_list_manager.dart';
import 'tag_selector.dart';
import 'web_article.dart';

ArticleListManager _articleListManager = ArticleListManager();
TagSelector _tagSelector = TagSelector();

void main() {
  _articleListManager.init().then((_) {
  });
}

void _displayArticleThumbnails(List<WebArticle> articles) {
  var articleListElement = querySelector('.article-list');
  articleListElement!.children = [];
  articleListElement.children
      .addAll(articles.map((e) => e.toHtmlElement()).toList());
}

void _insertCategoryList() {
  
}
