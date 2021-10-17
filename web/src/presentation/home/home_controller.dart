import 'dart:html';

import '../../model/article_category.dart';
import '../../model/tag.dart';
import '../../pool/article_category_pool.dart';
import '../../pool/article_tag_pool.dart';

class HomeController {
  static void onClickCategory(Event event, HtmlElement categoryHtmlElement, String categoryName) {
    querySelectorAll('.category').forEach((e) => e.style.background = '');

    categoryHtmlElement.style.background = '#7c7c7c';
    event.stopPropagation();
    ArticleCategoryPool().select(ArticleCategory(categoryName));
  }

  static void onClickTag(Event event, HtmlElement tagElement, Tag tag) {
    if (ArticleTagPool().getSelectedTags().contains(tag)) {
      tagElement.remove();
      var unselectedListHtmlElement = querySelector('.unselected-tag-list');
      unselectedListHtmlElement!.children.add(tagElement);

      ArticleTagPool().deselect(tag);
    } else {
      tagElement.remove();
      var selectedListHtmlElement = querySelector('.selected-tag-list');
      selectedListHtmlElement!.children.add(tagElement);

      ArticleTagPool().select(tag);
    }
  }
}