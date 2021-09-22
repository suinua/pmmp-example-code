import 'dart:html';

class WebArticle {
  final String url;
  final List<WebTag> tags;

  final String title;
  final String body;

  WebArticle(
      {required String url,
      required List<WebTag> tags,
      required String title,
      required String body})
      : url = url,
        title = title,
        tags = tags,
        body = body;

  bool hasWebTag(List<WebTag> objects) {
    for (var i = 0; i < objects.length; i++) {
      if (tags.contains(objects[i])) return true;
    }

    return false;
  }

  WebArticle.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        tags = List<Map<String, String>>.from(json['tags'])
            .map((element) =>
                WebTag(WebTagCategory(element['category']), element['text']))
            .toList(),
        title = json['title'],
        body = json['body'];

  HtmlElement toHtmlElement() {
    var articleElement = AnchorElement(href: url)..className = 'article';
    var titleElement = DivElement()
      ..className = 'title'
      ..text = title;
    var conciseBodyElement = DivElement()
      ..className = 'concise-body'
      ..text = body;

    articleElement.children.addAll([titleElement, conciseBodyElement]);

    return articleElement;
  }
}

class WebTag {
  final WebTagCategory category;
  final text;

  const WebTag(this.category, this.text);

  @override
  bool operator ==(Object other) {
    if (other is WebTag) {
      return text == other.text;
    } else {
      return false;
    }
  }

  HtmlElement toHtmlElement() {
    return DivElement()
      ..text = text
      ..className = 'tag';
  }
}

class WebTagCategory {
  final text;

  WebTagCategory(this.text);
}

class BasedWebTagCategory {
  final text;
  final List<BasedWebTagCategory> children;

  static List<BasedWebTagCategory> parentCategories = [
    BasedWebTagCategory.Entity(),
    BasedWebTagCategory.Player(),
    BasedWebTagCategory.World(),
    BasedWebTagCategory.Particle(),
    BasedWebTagCategory.Effect(),
  ];

  //Entity
  BasedWebTagCategory.Entity()
      : text = 'Entity',
        children = [BasedWebTagCategory.Zombie()];

  BasedWebTagCategory.Zombie()
      : text = 'Zombie',
        children = [];

  //Player
  BasedWebTagCategory.Player()
      : text = 'Player',
        children = [];

  //World
  BasedWebTagCategory.World()
      : text = 'World',
        children = [];

  //Particle
  BasedWebTagCategory.Particle()
      : text = 'Particle',
        children = [];

  //Effect
  BasedWebTagCategory.Effect()
      : text = 'Effect',
        children = [];

  //Plugin
  BasedWebTagCategory.Plugin()
      : text = 'Plugin',
        children = [BasedWebTagCategory.PVE()];
  BasedWebTagCategory.PVE()
      : text = 'PVE',
        children = [];
  BasedWebTagCategory.PVP()
      : text = 'PVP',
        children = [];
}


class WebArticleCategory {
  final text;

  WebArticleCategory(this.text);
}

class BasedWebArticleCategory {
  final text;
  final List<BasedWebArticleCategory> children;

  static List<BasedWebArticleCategory> parentCategories = [
    BasedWebArticleCategory.Entity(),
    BasedWebArticleCategory.Player(),
    BasedWebArticleCategory.World(),
    BasedWebArticleCategory.Particle(),
    BasedWebArticleCategory.Effect(),
  ];

  //Entity
  BasedWebArticleCategory.Entity()
      : text = 'Entity',
        children = [BasedWebArticleCategory.Zombie()];

  BasedWebArticleCategory.Zombie()
      : text = 'Zombie',
        children = [];

  //Player
  BasedWebArticleCategory.Player()
      : text = 'Player',
        children = [];

  //World
  BasedWebArticleCategory.World()
      : text = 'World',
        children = [];

  //Particle
  BasedWebArticleCategory.Particle()
      : text = 'Particle',
        children = [];

  //Effect
  BasedWebArticleCategory.Effect()
      : text = 'Effect',
        children = [];

  @override
  bool operator ==(Object other) {
    if (other is BasedWebArticleCategory) {
      return text == other.text;
    } else {
      return false;
    }
  }
}
