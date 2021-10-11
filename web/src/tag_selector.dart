import 'model/tag.dart';
import 'view/main_display.dart';

class TagSelector {
  static TagSelector? _instance;

  final List<Tag> _selectedTagList;

  TagSelector._internal() : _selectedTagList = [];

  factory TagSelector() {
    _instance ??= TagSelector._internal();
    return _instance!;
  }

  void select(Tag tag) {
    if (_selectedTagList.contains(tag)) return;
    _selectedTagList.add(tag);

    showArticleThumbnails();
  }

  void deselect(Tag tag) {
    if (!_selectedTagList.contains(tag)) return;
    _selectedTagList.remove(tag);

    showArticleThumbnails();
  }

  List<Tag> getSelectedTags() {
    return _selectedTagList;
  }
}
