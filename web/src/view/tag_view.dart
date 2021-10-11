import 'dart:html';

import '../model/tag.dart';
import '../tag_selector.dart';

class TagView {
  static HtmlElement convert(DefinedTag definedTag,
      {bool isTopParent = false}) {
    var tag = definedTag.toTag();

    var liElement = LIElement()
      ..text = tag.text
      ..className = 'tag';

    liElement.onClick.listen((event) {
      event.stopPropagation();
      if (TagSelector().getSelectedTags().contains(tag)) {
        TagSelector().deselect(tag);
        liElement.style.background = '';
      } else {
        TagSelector().select(definedTag.toTag());
        liElement.style.background = '#7c7c7c';
      }
    });

    //todo:リファクタリング　正直なぜうまくいってるか理解できない
    if (isTopParent) {
      var ulListElement = UListElement();
      ulListElement.children.add(liElement);

      var childrenAsHtml = definedTag.children.map((e) => convert(e)).toList();
      var childrenWrapElement = UListElement();
      childrenWrapElement.children.addAll(childrenAsHtml);

      ulListElement.children.add(childrenWrapElement);
      return ulListElement;
    }

    if (definedTag.children.isNotEmpty) {
      var childrenAsHtml = definedTag.children.map((e) => convert(e)).toList();
      var childrenWrapElement = UListElement();
      childrenWrapElement.children.addAll(childrenAsHtml);
      liElement.children.add(childrenWrapElement);
    }

    return liElement;
  }
}
