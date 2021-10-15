import 'model/article_category.dart';
import 'tag_selector.dart';
import 'view/main_display.dart';

class CategorySelector {
  static CategorySelector? _instance;

  ArticleCategory? _selectedCategory;

  CategorySelector._internal();

  factory CategorySelector() {
    _instance ??= CategorySelector._internal();
    return _instance!;
  }

  void select(ArticleCategory category) {
    _selectedCategory = category;

    showArticleThumbnails();
    TagSelector().refresh();
    updateTagListView();
  }

  void deselect(ArticleCategory category) {
    _selectedCategory = null;

    showArticleThumbnails();
    TagSelector().refresh();
    updateTagListView();
  }

  ArticleCategory? getSelectedTags() {
    return _selectedCategory;
  }
}
