import 'presentation/home/home.dart';
import 'store/articles_store.dart';

void main() {
  ArticlesStore().init().then((_) {
    Home.init();
  });
}
