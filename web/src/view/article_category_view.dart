import 'dart:html';

import '../category_selector.dart';
import '../model/article_category.dart';

class ArticleCategoryView {
  static HtmlElement convert(DefinedArticleCategory articleCategory) {
    var element = DivElement()
      ..text = articleCategory.text
      ..className = 'category';
    element.onClick.listen((event) {
      querySelectorAll('.category').forEach((e) => e.style.background = '');

      element.style.background = '#7c7c7c';
      event.stopPropagation();
      CategorySelector().select(articleCategory);
    });
    var childrenAsHtml = articleCategory.children.map((e) => convert(e)).toList();

    element.children.addAll(childrenAsHtml);
    return element;
  }
}