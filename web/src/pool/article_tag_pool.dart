import '../model/article.dart';
import '../model/tag.dart';

class ArticleTagPool {
  static ArticleTagPool? _instance;

  List<Tag> _unselectedTagList;
  List<Tag> _selectedTagList;

  ArticleTagPool._internal()
      : _unselectedTagList = [],
        _selectedTagList = [];

  factory ArticleTagPool() {
    _instance ??= ArticleTagPool._internal();
    return _instance!;
  }

  void refresh(List<Article> articles) {
    var allTags = <Tag>[];

    articles.forEach((article) {
      article.tags.forEach((tag) {
        if (!allTags.contains(tag)) allTags.add(tag);
      });
    });
    allTags.sort((a, b) => a.text.compareTo(b.text));
    _unselectedTagList = allTags;

    for (var i=0; i < _selectedTagList.length; i++) {
      var selectedTag = _selectedTagList[i];
      if (allTags.contains(selectedTag)) {
        _unselectedTagList.remove(selectedTag);
      } else {
        _selectedTagList.remove(selectedTag);
      }
    }
  }

  void select(Tag tag) {
    if (_selectedTagList.contains(tag)) return;
    _selectedTagList.add(tag);
    _unselectedTagList.remove(tag);

  }

  void deselect(Tag tag) {
    if (!_selectedTagList.contains(tag)) return;
    _selectedTagList.remove(tag);
    _unselectedTagList.add(tag);
  }

  void clearSelectedTags() {
    _selectedTagList.clear();
  }

  List<Tag> getSelectedTags() {
    return _selectedTagList;
  }

  List<Tag> getUnselectedTags() {
    return _unselectedTagList;
  }
}