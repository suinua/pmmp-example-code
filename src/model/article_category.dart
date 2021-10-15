class ArticleCategory {
  final text;

  ArticleCategory(this.text);

  @override
  bool operator ==(Object other) {
    if (other is ArticleCategory) {
      return text == other.text;
    } else {
      return false;
    }
  }
}
