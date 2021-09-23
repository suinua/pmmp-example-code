import 'dart:html';

import 'article_list_manager.dart';
import 'tag_selector.dart';
import 'web_article_category.dart';
import 'web_tag.dart';



void main() {
  var _articleListManager = ArticleListManager();
  TagSelector();

  _articleListManager.init().then((_) {
    _insertCategoryList();
    _insertTagList();
  });
}

void _insertCategoryList() {
  var categoryListHtmlElement = querySelector('.category-list');
  var elements = DefinedArticleCategory.parentCategories.map((e) => e.toHtmlElement());
  categoryListHtmlElement!.children.addAll(elements);
}

void _insertTagList() {
  var categoryListHtmlElement = querySelector('.tag-list');
  var elements = DefinedWebTag.parentCategories.map((e) => e.toHtmlElement());
  categoryListHtmlElement!.children.addAll(elements);
}
