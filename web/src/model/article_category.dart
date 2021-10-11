//純粋なカテゴリー、カテゴリー名しか持たない
class ArticleCategory {
  final text;
  final List<ArticleCategory> parents;

  ArticleCategory(this.parents, this.text);

  @override
  bool operator ==(Object other) {
    if (other is ArticleCategory) {
      return text == other.text;
    } else {
      return false;
    }
  }
}

//定義済みのカテゴリー、カテゴリー名と親のタグを持つ
class DefinedArticleCategory {
  final text;
  final List<DefinedArticleCategory> children;

  ArticleCategory toArticleCategory() {
    return ArticleCategory([], text);
  }

  static List<DefinedArticleCategory> parentCategories = [
    DefinedArticleCategory.Entity(),
    DefinedArticleCategory.Player(),
    DefinedArticleCategory.World(),
    DefinedArticleCategory.Particle(),
    DefinedArticleCategory.Effect(),
  ];

  //Entity
  DefinedArticleCategory.Entity()
      : text = 'Entity',
        children = [DefinedArticleCategory.Zombie(), DefinedArticleCategory.Projectile()];

  DefinedArticleCategory.Zombie()
      : text = 'Zombie',
        children = [];

  DefinedArticleCategory.Projectile()
      : text = 'Projectile',
        children = [DefinedArticleCategory.Snowball()];

  DefinedArticleCategory.Snowball()
      : text = 'Snowball',
        children = [];

  //Player
  DefinedArticleCategory.Player()
      : text = 'Player',
        children = [];

  //World
  DefinedArticleCategory.World()
      : text = 'World',
        children = [];

  //Particle
  DefinedArticleCategory.Particle()
      : text = 'Particle',
        children = [];

  //Effect
  DefinedArticleCategory.Effect()
      : text = 'Effect',
        children = [];

  @override
  bool operator ==(Object other) {
    if (other is DefinedArticleCategory) {
      return text == other.text;
    } else {
      return false;
    }
  }
}
