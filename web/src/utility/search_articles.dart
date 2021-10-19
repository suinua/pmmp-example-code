import '../model/article.dart';

class SearchArticles {
  static List<Article> execute(List<Article> allArticles, String text) {
    var result = <Article>[];

    allArticles.forEach((article) {
      if (RegExp(text).hasMatch(article.title))  {
        result.add(article);
      } else if (RegExp(text).hasMatch(article.body)) {
        result.add(article);
      }
    });

    return result;
  }
}