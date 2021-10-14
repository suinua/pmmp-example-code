class Tag {
  final String text;

  const Tag(this.text);

  @override
  bool operator ==(Object other) {
    if (other is Tag) {
      return text == other.text;
    } else {
      return false;
    }
  }
}