import 'dart:html';

import '../../model/article.dart';
import '../../pool/article_category_pool.dart';
import '../../pool/article_tag_pool.dart';
import '../../store/articles_store.dart';
import '../../utility/FilterArtciles.dart';
import 'home.dart';
import 'home_controller.dart';

class HomeService {
  static void setUpCategoryListView() {
    var categoryListHtmlElement = querySelector('#category-list');
    var elements = Home.categoryListToHtmlElement(ArticlesStore().getCategoryData(), null);
    categoryListHtmlElement!.children.add(elements);

    //uikitが反映されないため、setInnerHtmlで更新する。
    //また、uk-navが消えないようにvalidatorを設定しなきゃいけない。
    var htmlValidator = NodeValidatorBuilder
        .common()
      ..allowElement('a',attributes: ['category-name'])
      ..allowElement('ul',attributes: ['uk-nav']);
    var content = categoryListHtmlElement.innerHtml;
    categoryListHtmlElement.setInnerHtml(content!, validator: htmlValidator);

    //イベントの登録
    querySelectorAll('#category-selector').forEach((aElement) {
      if (aElement is HtmlElement) {
        aElement.onClick.listen((event) =>
            HomeController.onClickCategory(event, aElement, aElement.getAttribute('category-name')!));
      }
    });
  }

  static void updateArticlesListView(List<Article> articles) {
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