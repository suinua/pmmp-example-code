import 'dart:html';

import '../../pool/article_category_pool.dart';
import '../../pool/article_tag_pool.dart';
import '../../store/articles_store.dart';
import '../../utility/FilterArtciles.dart';
import 'home.dart';

class HomeService {
  static void setUpCategoryListView() {
    var categoryListHtmlElement = querySelector('.category-list');
    var elements = Home.categoryListToHtmlElement(ArticlesStore().getCategoryData(), null);
    categoryListHtmlElement!.children.add(elements);
  }

  static void updateArticlesListView() {
    var articles = FilterArticles.execute(
      ArticlesStore().getArticles(),
      ArticlesStore().getCategoryData(),
        category: ArticleCategoryPool().getSelectedCategory(),
        tags: ArticleTagPool().getSelectedTags(),
    );

    var articleListElement = querySelector('.article-list');
    articleListElement!.children = [];
    articleListElement.children.addAll(articles.map((article) => Home.articleToHtmlElement(article)).toList());
  }


  static void updateTagListView() {
    var selectedTagListElement = querySelector('.selected-tag-list')!..children.clear();
    var unselectedTagListElement = querySelector('.unselected-tag-list')!..children.clear();

    ArticleTagPool().getSelectedTags().forEach((selectedTag) {
      selectedTagListElement.children.add(Home.tagToHtmlElement(selectedTag));
    });

    ArticleTagPool().getUnselectedTags().forEach((unselectedTag) {
      unselectedTagListElement.children.add(Home.tagToHtmlElement(unselectedTag));
    });
  }
}