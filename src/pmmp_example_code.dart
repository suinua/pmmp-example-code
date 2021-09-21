import 'dart:convert';
import 'dart:io';

import 'package:markdown/markdown.dart';

import 'article.dart';

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

  var articleList = <Article>[];
  for (var index = 0; index < files.length; index++) {
    var file = File(files[index].path);
    var text = await file.readAsString();

    var tags = getTagsFromMarkdown(text);
    var bodyText = getBodyText(text);
    var title = getTitle(text);

    articleList.add(
        Article(url: '', tags: tags, title: title, body: bodyText));
  }

  var outputPath = basePath + r'web\';
  var articleListAsJson = <String, Map<String,dynamic>>{};
  var i=0;
  articleList.forEach((markdownFileData) {
    generateHtml(markdownFileData, outputPath);
    articleListAsJson[i.toString()] = markdownFileData.toJson();
    i++;
  });

  saveArticleData(articleListAsJson, basePath);
}

String getTitle(String markdown) {
  var title = RegExp(r'#(.*)').firstMatch(markdown)?.group(0);
  assert(title != null);

  return title!.replaceAll('# ', '');
}

List<Tag> getTagsFromMarkdown(String markdown) {
  var line = markdown.split('\n').first;
  return line.split(' ').map((e) => Tag(e.replaceAll('\r', ''))).toList();
}

String getBodyText(String markdown) {
  return markdown
      .replaceFirst(RegExp('^(.*)'), '')
      .replaceFirst(RegExp('#(.*)'), '');
}

void generateHtml(Article fileData, String path) {
  var html = markdownToHtml(fileData.body);
  //todo:main.dart(js)を読み込ませる
  File(path + fileData.title + '.html')
      .create()
      .then((value) => value.writeAsString(html));
}

void saveArticleData(Map data,String path) {
  var json = jsonEncode(data);
  File(path + 'data.json').create().then((value) => value.writeAsString(json));
}