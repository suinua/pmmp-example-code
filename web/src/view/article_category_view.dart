import 'dart:html';

import '../category_selector.dart';
import '../model/article_category.dart';

class ArticleCategoryView {
  static HtmlElement convert(
      Map<String, dynamic> categoryData, HtmlElement? parent) {

    parent ??= UListElement();

    categoryData.forEach((categoryName, value) {
      var liElement = LIElement()
        ..text = categoryName
        ..className = 'category';

      liElement.onClick.listen((event) {
        querySelectorAll('.category').forEach((e) => e.style.background = '');

        liElement.style.background = '#7c7c7c';
        event.stopPropagation();
        CategorySelector().select(ArticleCategory(categoryName));
      });


      if (value is Map<String, dynamic>) {
        if (value.isNotEmpty) {
          var childrenWrapElement = UListElement();
          var childrenAsHtml = convert(value, childrenWrapElement);

          liElement.children.add(childrenAsHtml);
          parent!.children.add(liElement);
        } else {
          parent!.children.add(liElement);
        }
      }
    });

    return parent;
  }
}
