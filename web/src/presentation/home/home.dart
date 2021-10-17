import 'dart:html';

import '../../model/article.dart';
import '../../model/article_category.dart';
import '../../model/tag.dart';
import '../../pool/article_category_pool.dart';
import '../../pool/article_tag_pool.dart';
import 'home_controller.dart';

class Home {
  static HtmlElement articleToHtmlElement(Article article) {
    var articleElement = AnchorElement(href: article.url)
      ..className = 'article';
    var titleElement = DivElement()
      ..className = 'title'
      ..text = article.title;
    var conciseBodyElement = DivElement()
      ..className = 'concise-body'
      ..text = article.body;

    articleElement.children.addAll([titleElement, conciseBodyElement]);

    return articleElement;
  }

  static HtmlElement tagToHtmlElement(Tag tag) {
    var tagElement = DivElement()
      ..className = 'tag'
      ..text = tag.text;

    tagElement.onClick.listen((event) => HomeController.onClickTag(event, tagElement, tag));

    return tagElement;
  }

  static HtmlElement categoryListToHtmlElement(
      Map<String, dynamic> categoryData, HtmlElement? parent) {
    parent ??= UListElement();

    categoryData.forEach((categoryName, value) {
      var liElement = LIElement()
        ..text = categoryName
        ..className = 'category';

      liElement.onClick.listen((event) => HomeController.onClickCategory(event, liElement, categoryName));

      if (value is Map<String, dynamic>) {
        if (value.isNotEmpty) {
          var childrenWrapElement = UListElement();
          var childrenAsHtml =
              categoryListToHtmlElement(value, childrenWrapElement);

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
