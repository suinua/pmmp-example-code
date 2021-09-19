class MarkdownFileData {
  final String url;
  final List<Tag> tags;

  final String title;
  final String body;

  MarkdownFileData({required String url, required List<Tag> tags,  required String title, required String body})
      : url = url,
        title = title,
        tags = tags,
        body = body;

  Map<String,dynamic> toJson() {
    //todo
  }
}

class Tag {
  final text;

  Tag(this.text);

  Tag.Entity() : text = 'Entity';
}
