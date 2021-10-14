import 'dart:html';

import '../model/tag.dart';
import '../tag_selector.dart';

class TagView {
  static HtmlElement convert(Tag tag) {
    var tagElement = DivElement()
      ..className = 'tag'
      ..text = tag.text;

    tagElement.onClick.listen((event) {
      if (TagSelector().getSelectedTags().contains(tag)) {
        tagElement.remove();
        var unselectedListHtmlElement = querySelector('.unselected-tag-list');
        unselectedListHtmlElement!.children.add(tagElement);

        TagSelector().deselect(tag);
      } else {
        tagElement.remove();
        var selectedListHtmlElement = querySelector('.selected-tag-list');
        selectedListHtmlElement!.children.add(tagElement);

        TagSelector().select(tag);
      }
    });

    return tagElement;
  }
}
