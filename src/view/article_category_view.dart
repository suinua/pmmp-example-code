import 'dart:html';

import '../category_selector.dart';
import '../model/article_category.dart';

class ArticleCategoryView {
  static HtmlElement convert(DefinedArticleCategory articleCategory,
      {bool isTopParent = false}) {
    var liElement = LIElement()
      ..text = articleCategory.text
      ..className = 'category';

    liElement.onClick.listen((event) {
      querySelectorAll('.category').forEach((e) => e.style.background = '');

      liElement.style.background = '#7c7c7c';
      event.stopPropagation();
      CategorySelector().select(articleCategory);
    });

    if (isTopParent) {
      var ulListElement = UListElement();
      ulListElement.children.add(liElement);

      var childrenAsHtml =
          articleCategory.children.map((e) => convert(e)).toList();
      var childrenWrapElement = UListElement();
      childrenWrapElement.children.addAll(childrenAsHtml);

      ulListElement.children.add(childrenWrapElement);
      return ulListElement;
    }

    if (articleCategory.children.isNotEmpty) {
      var childrenAsHtml =
          articleCategory.children.map((e) => convert(e)).toList();
      var childrenWrapElement = UListElement();
      childrenWrapElement.children.addAll(childrenAsHtml);
      liElement.children.add(childrenWrapElement);
    }

    return liElement;
  }
}
