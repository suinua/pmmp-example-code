import 'dart:html';

import '../article_list_manager.dart';
import '../category_selector.dart';
import '../tag_selector.dart';
import 'article_view.dart';

void showArticleThumbnails() {
  var articles = ArticleListManager().find(TagSelector().getSelectedTags(), CategorySelector().getSelectedTags());

  var articleListElement = querySelector('.article-list');
  articleListElement!.children = [];
  articleListElement.children
      .addAll(articles.map((article) => ArticleView.convert(article)).toList());
}