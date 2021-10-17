import 'dart:html';

import 'presentation/home/home_service.dart';
import 'store/articles_store.dart';

void main() {
  ArticlesStore().init().then((_) {
    HomeService.setUpCategoryListView();
  });
}
