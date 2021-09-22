import 'web_article.dart';

class TagSelector {
  final List<WebTag> _selectedTagList;

  TagSelector():_selectedTagList = [];

  void select(WebTag tag) {
    if (_selectedTagList.contains(tag)) return;
    _selectedTagList.add(tag);
  }

  void deselect(WebTag tag) {
    if (!_selectedTagList.contains(tag)) return;
    _selectedTagList.remove(tag);
  }

  List<WebTag> getSelectedTags() {
    return _selectedTagList;
  }
}