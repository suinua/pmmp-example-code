import 'web_tag.dart';

class TagSelector {
  static TagSelector? _instance;

  final List<WebTag> _selectedTagList;

  TagSelector._internal() : _selectedTagList = [];

  factory TagSelector() {
    _instance ??= TagSelector._internal();
    return _instance!;
  }

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
