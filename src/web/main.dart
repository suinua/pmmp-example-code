import 'dart:html';

import 'article_list_manager.dart';
import 'tag_selector.dart';
import 'web_article.dart';

ArticleListManager _articleListManager = ArticleListManager();
TagSelector _tagSelector = TagSelector();

void main() {
  _articleListManager.init().then((_) {
    _insertTags();
  });
}

void _insertTags() {
  var tagListElement = querySelector('.tag-list');
  assert(tagListElement != null);

  WebTag.defaultTags.forEach((WebTag tag) {
    var tagElement = tag.toHtmlElement();
    tagElement.onClick.listen((_) => _onSelectedTag(tag, tagElement));

    tagListElement!.children.add(tagElement);
  });
}

void _displayArticleThumbnails(List<WebArticle> articles) {
  var articleListElement = querySelector('.article-list');
  articleListElement!.children = [];
  articleListElement.children
      .addAll(articles.map((e) => e.toHtmlElement()).toList());
}

void _onSelectedTag(WebTag tag, HtmlElement tagElement) {
  _tagSelector.select(tag);
  _displayArticleThumbnails(
      _articleListManager.findByTags(_tagSelector.getSelectedTags()));

  tagElement.style.display = 'none';

  var selectedTagElement = DivElement()
    ..className = 'selected-tag'
    ..text = tag.text;

  selectedTagElement.onClick.listen((event) {
    _tagSelector.deselect(tag);

    tagElement.style.display = '';
    selectedTagElement.remove();
    _displayArticleThumbnails(
        _articleListManager.findByTags(_tagSelector.getSelectedTags()));
  });

  querySelector('.selected-tag-list')?.children.add(selectedTagElement);
}
