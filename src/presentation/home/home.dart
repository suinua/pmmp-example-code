import 'dart:html';
import 'dart:svg';

import '../../model/article.dart';
import '../../model/tag.dart';
import 'home_controller.dart';
import 'home_service.dart';

class Home {
  static void init() {
    HomeService.setUpCategoryListView();
    querySelector('#search')
        ?.onKeyPress
        .listen(HomeController.onKeyPressInSearchInput);
  }

  static HtmlElement articleToHtmlElement(Article article) {
    HtmlElement _articleTagElement(Tag tag) {
      return DivElement()
        ..style.backgroundColor = '#58ACFA'
        ..style.padding = '3px 6px'
        ..style.marginRight = '8px'
        ..style.marginLeft = '1px'
        ..style.fontSize = '75%'
        ..style.color = 'white'
        ..style.borderRadius = '6px'
        ..style.boxShadow = '0 0 3px #ddd'
        ..style.whiteSpace = 'nowrap'
        ..text = tag.text
        ..className = 'article-tags';
    }

    var articleElement = AnchorElement(href: article.url)
      ..className = 'article'
      ..children = [
        DivElement()
          ..className = 'title'
          ..text = article.title,
        DivElement()
          ..style.fontSize = '90%'
          ..style.fontFamily = 'Be Vietnam Pro'
          ..style.color= '#969696'
          ..style.overflow= 'hidden'
          ..className = 'concise-body'
          ..text = article.body,
        DivElement()
          ..children = article.tags.map((e) => _articleTagElement(e)).toList()
      ];

    return articleElement;
  }

  static HtmlElement tagToHtmlElement(Tag tag) {
    var tagElement = DivElement()
      ..className = 'tag'
      ..text = tag.text;

    tagElement.onClick
        .listen((event) => HomeController.onClickTag(event, tagElement, tag));

    return tagElement;
  }

  static HtmlElement categoryListToHtmlElement(
      Map<String, dynamic> categoryData, HtmlElement? parent) {
    var isTopLayer = false;
    if (parent == null) {
      isTopLayer = true;
      parent = UListElement()..className = 'uk-nav uk-nav-default';
    }

    categoryData.forEach((categoryName, value) {
      var liElement = LIElement()
        ..className = isTopLayer ? 'uk-parent' : ''
        ..children = [
          AElement()
            ..setAttribute('category-name', categoryName)
            ..id = 'category-selector'
            ..setAttribute('href', '#')
            ..text = categoryName
        ];

      parent!.children.add(liElement);

      if (value is Map<String, dynamic>) {
        if (value.isNotEmpty) {
          var childrenWrapElement = UListElement()
            ..className = isTopLayer ? 'uk-nav-sub' : '';
          var childrenAsHtml =
              categoryListToHtmlElement(value, childrenWrapElement);

          liElement.children.add(childrenAsHtml);
        }
      }

      if (isTopLayer) {
        parent.children.add(LIElement()..className = 'uk-nav-divider');
      }
    });

    return parent;
  }
}
