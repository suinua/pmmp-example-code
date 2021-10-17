import '../model/article.dart';
import '../model/article_category.dart';
import '../model/tag.dart';
import '../store/articles_store.dart';

class FilterArticles {
  static List<Article> execute(
      List<Article> allArticles, Map<String, dynamic> categoriesData,
      {ArticleCategory? category, List<Tag> tags = const []}) {
    var allArticles = ArticlesStore().getArticles();

    //タグが一致する記事
    var articles = tags.isEmpty
        ? allArticles
        : allArticles.where((element) => element.hasTag(tags)).toList();

    if (category == null) return articles;

    var articleCategoryList = _arrangeCategoryChildren(_getCategoryChildren(category,categoriesData), []);
    articleCategoryList.add(category);

    //カテゴリと一致するものだけをとりだす
    var result = <Article>[];
    for (var i = 0; i < articles.length; i++) {
      var article = articles[i];
      if (articleCategoryList.contains(article.category)) {
        result.add(article);
      }
    }

    return result;
  }

  static Map<String, dynamic> _getCategoryChildren(
      ArticleCategory targetCategory, Map<String, dynamic> categoryData) {
    for (var name in categoryData.keys) {
      if (name == targetCategory.text) {
        return Map<String, dynamic>.from(categoryData[name]);
      } else {
        var result = _getCategoryChildren(targetCategory, categoryData[name]);
        if (result.isNotEmpty) return result;
      }
    }

    return {};
  }

  static List<ArticleCategory> _arrangeCategoryChildren(
      Map<String, dynamic> data, List<ArticleCategory> result) {
    var res = List<ArticleCategory>.from(result);

    for (var categoryName in data.keys) {
      res.addAll(_arrangeCategoryChildren(
          Map<String, dynamic>.from(data[categoryName]), res));
      res.add(ArticleCategory(categoryName));
    }

    return res;
  }
}
