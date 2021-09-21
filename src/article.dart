class Article {
  final String url;
  final List<Tag> tags;

  final String title;
  final String body;

  Article({required String url,
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

  Article.fromJson(Map json)
      :
        url = json['url'],
        tags = json['tags'].map((e) => Tag(e)).toList(),
        title = json['title'],
        body = json['body'];
}

class Tag {
  final text;
  Tag(this.text);
}
