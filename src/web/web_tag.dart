import 'dart:html';

import 'article_list_manager.dart';
import 'main_display.dart';
import 'tag_selector.dart';

class WebTag {
  final text;

  const WebTag(this.text);

  @override
  bool operator ==(Object other) {
    if (other is WebTag) {
      return text == other.text;
    } else {
      return false;
    }
  }
}

class DefinedWebTag {
  final text;
  final List<DefinedWebTag> children;

  WebTag toWebTag() {
    return WebTag(text);
  }

  static List<DefinedWebTag> parentCategories = [
    DefinedWebTag.Entity(),
    DefinedWebTag.Player(),
    DefinedWebTag.World(),
    DefinedWebTag.Particle(),
    DefinedWebTag.Effect(),
    DefinedWebTag.Plugin()
  ];

  //Entity
  DefinedWebTag.Entity()
      : text = 'Entity',
        children = [DefinedWebTag.Zombie()];

  DefinedWebTag.Zombie()
      : text = 'Zombie',
        children = [];

  //Player
  DefinedWebTag.Player()
      : text = 'Player',
        children = [];

  //World
  DefinedWebTag.World()
      : text = 'World',
        children = [];

  //Particle
  DefinedWebTag.Particle()
      : text = 'Particle',
        children = [];

  //Effect
  DefinedWebTag.Effect()
      : text = 'Effect',
        children = [];

  //Plugin
  DefinedWebTag.Plugin()
      : text = 'Plugin',
        children = [DefinedWebTag.PVE(),DefinedWebTag.PVP()];
  DefinedWebTag.PVE()
      : text = 'PVE',
        children = [];
  DefinedWebTag.PVP()
      : text = 'PVP',
        children = [];

  HtmlElement toHtmlElement() {
    var element = DivElement()
      ..text = text
      ..className = 'tag';

    element.onClick.listen((event) {
      event.stopPropagation();
      TagSelector().select(toWebTag());
      showArticleThumbnails(ArticleListManager().findByTags(TagSelector().getSelectedTags()));
    });

    var childrenAsHtml = children.map((e) => e.toHtmlElement()).toList();

    element.children.addAll(childrenAsHtml);
    return element;
  }
}