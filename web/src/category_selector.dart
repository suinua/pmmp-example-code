import 'model/article_category.dart';
import 'tag_selector.dart';
import 'view/main_display.dart';

class CategorySelector {
  static CategorySelector? _instance;

  DefinedArticleCategory? _selectedCategory;

  CategorySelector._internal();

  factory CategorySelector() {
    _instance ??= CategorySelector._internal();
    return _instance!;
  }

  void select(DefinedArticleCategory category) {
    _selectedCategory = category;

    showArticleThumbnails();
    TagSelector().refresh();
    updateTagListView();
  }

  void deselect(DefinedArticleCategory category) {
    _selectedCategory = null;

    showArticleThumbnails();
    TagSelector().refresh();
    updateTagListView();
  }

  DefinedArticleCategory? getSelectedTags() {
    return _selectedCategory;
  }
}