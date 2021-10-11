import 'dart:html';

import '../model/tag.dart';
import '../tag_selector.dart';

class TagView {
  static HtmlElement convert(DefinedTag definedTag) {
    var tag = definedTag.toTag();
    var element = DivElement()
      ..text = tag.text
      ..className = 'tag';

    element.onClick.listen((event) {
      event.stopPropagation();
      if (TagSelector().getSelectedTags().contains(tag)) {
        TagSelector().deselect(tag);
        element.style.background = '';
      } else {
        TagSelector().select(definedTag.toTag());
        element.style.background = '#7c7c7c';
      }
    });

    var childrenAsHtml = definedTag.children.map((e) => convert(e)).toList();

    element.children.addAll(childrenAsHtml);
    return element;
  }
}