import 'article_category.dart';
import 'tag.dart';

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

  bool hasTag(List<Tag> objects) {
    for (var i = 0; i < objects.length; i++) {
      if (tags.contains(objects[i])) return true;
    }

    return false;
  }

  Article.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        category = ArticleCategory(json['category']),
        tags = List<String>.from(json['tags'])
            .map((element) => Tag(element))
            .toList(),
        title = json['title'],
        body = json['body'];
}
