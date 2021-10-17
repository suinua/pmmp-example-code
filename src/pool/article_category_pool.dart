import '../model/article_category.dart';

class ArticleCategoryPool {
  ArticleCategory? _selectedCategory;

  static ArticleCategoryPool? _instance;

  ArticleCategoryPool._internal();

  factory ArticleCategoryPool() {
    _instance ??= ArticleCategoryPool._internal();
    return _instance!;
  }

  void select(ArticleCategory category) {
    _selectedCategory = category;
  }

  void deselect(ArticleCategory category) {
    _selectedCategory = null;
  }
  
  ArticleCategory? getSelectedCategory() {
    return _selectedCategory;
  }
}