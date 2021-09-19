import 'dart:io';

import 'package:markdown/markdown.dart';

import 'MarkdownFileData.dart';

void main() {
  convertMarkdownToHtml();
}

void convertMarkdownToHtml() async {
  var basePath = '';
  Platform.script.pathSegments.asMap().forEach((key, element) {
    if (key < 4) {
      basePath = key == 0 ? element : basePath + '\\$element';
    }
  });
  basePath += r'\';

  var markdownFolderPath = basePath + r'markdown\';
  var dir = Directory(markdownFolderPath);
  var files = await dir.list().toList();

  var fileDataList = <MarkdownFileData>[];
  for (var index = 0; index < files.length; index++) {
    var file = File(files[index].path);
    var text = await file.readAsString();

    var tags = getTagsFromMarkdown(text);
    var bodyText = getBodyText(text);
    var title = getTitle(text);

    fileDataList.add(
        MarkdownFileData(url: '', tags: tags, title: title, body: bodyText));
  }

  var outputPath = basePath + r'output\';
  fileDataList.forEach((markdownFileData) {
    generateHtml(markdownFileData, outputPath);
  });

  //todo:firebaseに保存
}

String getTitle(String markdown) {
  var title = RegExp(r'#(.*)').firstMatch(markdown)?.group(0);
  assert(title != null);

  return title!.replaceAll('# ', '');
}

List<Tag> getTagsFromMarkdown(String markdown) {
  var line = markdown.split('\n').first;
  return line.split(' ').map((e) => Tag(e)).toList();
}

String getBodyText(String markdown) {
  return markdown
      .replaceFirst(RegExp('^(.*)'), '')
      .replaceFirst(RegExp('#(.*)'), '');
}

void generateHtml(MarkdownFileData fileData, String path) {
  var html = markdownToHtml(fileData.body);
  print(path);
  File(path + fileData.title + '.html').create().then((value) => value.writeAsString(html));
}
