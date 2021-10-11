//純粋なタグ、タグ名しか持たない
class Tag {
  final text;

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

//定義済みのタグ、タグ名と親のタグを持つ
class DefinedTag {
  final text;
  final List<DefinedTag> children;

  Tag toTag() {
    return Tag(text);
  }

  static List<DefinedTag> parentCategories = [
    DefinedTag.Entity(),
    DefinedTag.Player(),
    DefinedTag.World(),
    DefinedTag.Particle(),
    DefinedTag.Effect(),
    DefinedTag.Plugin()
  ];

  //Entity
  DefinedTag.Entity()
      : text = 'Entity',
        children = [DefinedTag.Zombie()];

  DefinedTag.Zombie()
      : text = 'Zombie',
        children = [];

  //Player
  DefinedTag.Player()
      : text = 'Player',
        children = [];

  //World
  DefinedTag.World()
      : text = 'World',
        children = [];

  //Particle
  DefinedTag.Particle()
      : text = 'Particle',
        children = [];

  //Effect
  DefinedTag.Effect()
      : text = 'Effect',
        children = [];

  //Plugin
  DefinedTag.Plugin()
      : text = 'Plugin',
        children = [DefinedTag.PVE(),DefinedTag.PVP()];
  DefinedTag.PVE()
      : text = 'PVE',
        children = [];
  DefinedTag.PVP()
      : text = 'PVP',
        children = [];
}