import 'dart:html';

import '../../model/article_category.dart';
import '../../model/tag.dart';
import '../../pool/article_category_pool.dart';
import '../../pool/article_tag_pool.dart';
import '../../store/articles_store.dart';
import '../../utility/filter_artciles.dart';
import 'home_service.dart';

class HomeController {
  static void onClickCategory(Event event, HtmlElement categoryHtmlElement, String categoryName) {
    querySelectorAll('#category-selector').forEach((e) => e.style.background = '');

    categoryHtmlElement.style.background = '#7c7c7c';
    ArticleCategoryPool().select(ArticleCategory(categoryName));

    var articles = FilterArticles.execute(
      ArticlesStore().getArticles(),
      ArticlesStore().getCategoryData(),
      category: ArticleCategoryPool().getSelectedCategory(),
      tags: ArticleTagPool().getSelectedTags(),
    );

    HomeService.updateArticlesListView(articles);

    ArticleTagPool().refresh(articles);
    HomeService.updateTagListView();
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

    var articles = FilterArticles.execute(
      ArticlesStore().getArticles(),
      ArticlesStore().getCategoryData(),
      category: ArticleCategoryPool().getSelectedCategory(),
      tags: ArticleTagPool().getSelectedTags(),
    );

    HomeService.updateArticlesListView(articles);
  }

  static void onKeyPressInSearchInput(KeyboardEvent event) {
    if (event.keyCode == 13) {
      var inputElement = querySelector('#search');
      if (inputElement is InputElement) {
        var text = inputElement.value;

        var articles = FilterArticles.execute(
            ArticlesStore().getArticles(),
            ArticlesStore().getCategoryData(),
            category: ArticleCategoryPool().getSelectedCategory(),
            tags: ArticleTagPool().getSelectedTags(),
            text: text ?? ''
        );

        HomeService.updateArticlesListView(articles);
      }
    }
  }
}