import 'dart:convert';
import 'dart:io';
import 'package:firebase/firebase_io.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

import 'package:markdown/markdown.dart';

import 'article.dart';

void main() {
  var basePath =  Platform.script.path.replaceFirst('bin/main.dart', '');

  convertMarkdownToHtml(basePath);
  deployCategoryData(basePath);
}

void deployCategoryData(String basePath) async {
  var jsonString = await File(basePath + 'data/category.json').readAsString();
  var credential = await Credentials.fetch();
  var fbClient = FirebaseClient(credential);
  await fbClient.post(
      'https://firebasestorage.googleapis.com/v0/b/pmmp-example-code.appspot.com/o/category.json',
      json.decode(jsonString));
}

void convertMarkdownToHtml(String basePath) async {
  var markdownFolderPath = basePath + 'markdown/';
  var dir = Directory(markdownFolderPath);
  var files = await dir.list().toList();

  var articleList = <Article>[];
  for (var index = 0; index < files.length; index++) {
    var file = File(files[index].path);
    var markdownText = await file.readAsString();
    articleList.add(markdownToArticle(markdownText));
  }

  var outputPath = basePath + 'web/';
  await Directory(outputPath).create();

  var articleListAsJson = <String, Map<String, dynamic>>{};
  var i = 0;
  articleList.forEach((markdownFileData) {
    generateHtml(markdownFileData, outputPath);
    articleListAsJson[i.toString()] = markdownFileData.toJson();
    i++;
  });

  saveArticleData(articleListAsJson);
}

//todo:不適当なCategoryだったらエラーをはくように
Article markdownToArticle(String markdown) {
  markdown = markdown.replaceAll('\r', '');
  var lines = markdown.split('\n');
  var articleCategoryLine = lines[0];
  var tagsLine = lines[1];
  var titleLine = lines[2];

  var title = titleLine.replaceAll('# ', '');
  var articleCategory =
      ArticleCategory(articleCategoryLine);

  var tags = <Tag>[];
  tagsLine.split(' ').toList().forEach((text) {
    tags.add(Tag(text));
  });

  var body = markdown.replaceAll(RegExp(r'(.*)\n(.*)\n#'), '');

  return Article(
      url: '$title.html',
      category: articleCategory,
      tags: tags,
      title: title,
      body: body);
}

void generateHtml(Article fileData, String path) {
  var html = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${fileData.title}</title>
    <link rel="stylesheet" href="css/article.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/styles/default.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/highlight.min.js"></script>
    <script>hljs.highlightAll();</script>
</head>
<body>
${markdownToHtml(fileData.body)}
</body>
</html>
  ''';
  File(path + fileData.title + '.html')
      .create()
      .then((value) => value.writeAsString(html));
}

void saveArticleData(Map data) async {
  var credential = await Credentials.fetch();
  var fbClient = FirebaseClient(credential);
  await fbClient.post(
      'https://firebasestorage.googleapis.com/v0/b/pmmp-example-code.appspot.com/o/data.json',
      data);
}

class Credentials {
  static Future<String> fetch() async {
    var pk = json.decode(Platform.environment['KEY']!);

    var accountCredentials = ServiceAccountCredentials.fromJson({
      'private_key_id': pk['private_key_id'],
      'private_key': pk['private_key'],
      'client_email': pk['client_email'],
      'client_id': pk['client_id'],
      'type': 'service_account',
    });

    var scopes = [
      'https://www.googleapis.com/auth/datastore',
      'https://www.googleapis.com/auth/cloud-platform'
    ];

    var client = http.Client();
    var credentials = await obtainAccessCredentialsViaServiceAccount(
        accountCredentials, scopes, client);
    client.close();
    return credentials.accessToken.data;
  }
}
