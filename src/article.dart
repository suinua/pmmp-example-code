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
    return {
      'url': url,
      'category': {
        'parents': category.parents.map((e) => e.text).toList(),
        'text': category.text
      },
      'tags': tags.map((e) => e.text).toList(),
      'title': title,
      'body': body
    };
  }
}

class Tag {
  final String text;

  const Tag(this.text);
}

class ArticleCategory {
  final text;
  final List<ArticleCategory> parents;

  const ArticleCategory(this.parents, this.text);
}
