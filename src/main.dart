import 'dart:html';

import 'article_list_manager.dart';
import 'tag_selector.dart';
import 'model/article_category.dart';
import 'view/article_category_view.dart';

void main() {
  var _articleListManager = ArticleListManager();
  TagSelector();

  _articleListManager.init().then((_) {
    _insertCategoryList();
  });
}

void _insertCategoryList() {
  var categoryListHtmlElement = querySelector('.category-list');
  var elements = DefinedArticleCategory.parentCategories
      .map((e) => ArticleCategoryView.convert(e, isTopParent: true));
  categoryListHtmlElement!.children.addAll(elements);
}
