import 'dart:html';

import 'article_list_manager.dart';
import 'tag_selector.dart';
import 'model/article_category.dart';
import 'model/tag.dart';
import 'view/article_category_view.dart';
import 'view/tag_view.dart';

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
  var elements = DefinedArticleCategory.parentCategories
      .map((e) => ArticleCategoryView.convert(e, isTopParent: true));
  categoryListHtmlElement!.children.addAll(elements);
}

void _insertTagList() {
  var categoryListHtmlElement = querySelector('.tag-list');
  var elements = DefinedTag.parentCategories
      .map((e) => TagView.convert(e, isTopParent: true));
  categoryListHtmlElement!.children.addAll(elements);
}
