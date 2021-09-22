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
    for (var i=0; i < objects.length; i++) {
      if (tags.contains(objects[i])) return true;
    }

    return false;
  }

  WebArticle.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        tags = List<String>.from(json['tags']).map((e) => WebTag(e)).toList(),
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
  final text;

  static const List<WebTag> defaultTags = [
    WebTag.Entity(),
    WebTag.Player(),
    WebTag.World(),
    WebTag.Particle(),
    WebTag.Effect(),
  ];

  const WebTag(this.text);

  const WebTag.Entity() : text = 'Entity';
  const WebTag.Player() : text = 'Player';
  const WebTag.World() : text = 'World';
  const WebTag.Particle() : text = 'Particle';
  const WebTag.Effect() : text = 'Effect';

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
