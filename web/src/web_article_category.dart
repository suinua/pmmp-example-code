import 'dart:html';

import 'article_list_manager.dart';
import 'main_display.dart';

class WebArticleCategory {
  final text;
  final List<WebArticleCategory> parents;

  WebArticleCategory(this.parents, this.text);

  @override
  bool operator ==(Object other) {
    if (other is WebArticleCategory) {
      return text == other.text;
    } else {
      return false;
    }
  }
}

class DefinedArticleCategory {
  final text;
  final List<DefinedArticleCategory> children;

  WebArticleCategory toWebArticleCategory() {
    return WebArticleCategory([], text);
  }

  static List<DefinedArticleCategory> parentCategories = [
    DefinedArticleCategory.Entity(),
    DefinedArticleCategory.Player(),
    DefinedArticleCategory.World(),
    DefinedArticleCategory.Particle(),
    DefinedArticleCategory.Effect(),
  ];

  //Entity
  DefinedArticleCategory.Entity()
      : text = 'Entity',
        children = [DefinedArticleCategory.Zombie(),DefinedArticleCategory.ProjectTile()];

  DefinedArticleCategory.Zombie()
      : text = 'Zombie',
        children = [];

  DefinedArticleCategory.ProjectTile()
      : text = 'ProjectTile',
        children = [DefinedArticleCategory.Snowball()];

  DefinedArticleCategory.Snowball()
      : text = 'Snowball',
        children = [];

  //Player
  DefinedArticleCategory.Player()
      : text = 'Player',
        children = [];

  //World
  DefinedArticleCategory.World()
      : text = 'World',
        children = [];

  //Particle
  DefinedArticleCategory.Particle()
      : text = 'Particle',
        children = [];

  //Effect
  DefinedArticleCategory.Effect()
      : text = 'Effect',
        children = [];

  @override
  bool operator ==(Object other) {
    if (other is DefinedArticleCategory) {
      return text == other.text;
    } else {
      return false;
    }
  }

  HtmlElement toHtmlElement() {
    var element = DivElement()
      ..text = text
      ..className = 'category';
    element.onClick.listen((event) {
      querySelectorAll('.category').forEach((e) => e.style.background = '');

      element.style.background = '#7c7c7c';
      event.stopPropagation();
      showArticleThumbnails(ArticleListManager().findByCategory(this));
    });
    var childrenAsHtml = children.map((e) => e.toHtmlElement()).toList();

    element.children.addAll(childrenAsHtml);
    return element;
  }
}
