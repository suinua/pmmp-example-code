class Article {
  final String url;
  final List<Tag> tags;

  final String title;
  final String body;

  Article(
      {required String url,
      required List<Tag> tags,
      required String title,
      required String body})
      : url = url,
        title = title,
        tags = tags,
        body = body;

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'tags': tags.map((e) => e.text).toList(),
      'title': title,
      'body': body
    };
  }

  Article.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        tags = List<String>.from(json['tags']).map((e) => Tag(e)).toList(),
        title = json['title'],
        body = json['body'];
}

class Tag {
  final text;
  static List<Tag> defaultTags = [
    Tag.Entity(),
  ];

  Tag(this.text);

  Tag.Entity() : text = 'Entity';

  @override
  bool operator ==(Object other) {
    if (other is Tag) {
      return text == other.text;
    } else {
      return false;
    }
  }
}
