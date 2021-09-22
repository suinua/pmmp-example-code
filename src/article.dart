class Article {
  final String url;
  final ArticleCategory category;
  final List<Tag> tags;

  final String title;
  final String body;

  Article(
      {required String url,
      required ArticleCategory category,
      required List<Tag> tags,
      required String title,
      required String body})
      : url = url,
        category = category,
        title = title,
        tags = tags,
        body = body;

  Map<String, dynamic> toJson() {
    var tagsAsJson = <Map<String, String>>[];

    tags.forEach((tag) {
      tagsAsJson.add({
        'category': tag.category.text,
        'text': tag.text,
      });
    });

    return {
      'url': url,
      'category': category.text,
      'tags': tagsAsJson,
      'title': title,
      'body': body
    };
  }
}

class Tag {
  final TagCategory category;
  final String text;

  const Tag(this.category, this.text);
}

class TagCategory {
  final text;

  const TagCategory(this.text);
}

class ArticleCategory {
  final text;

  const ArticleCategory(this.text);
}
