class Recipe {

  Recipe({
  required this.recipeTitle,
  required this.recipeRecipe,
    this.imagePath = "assets/default/recipe_default_image.png",
    this.favourite = false,
    this.id = 0
  });

  String recipeTitle;
  String recipeRecipe;
  String imagePath;
  bool favourite;
  int id;

  Recipe.fromJson(Map json) :
      recipeTitle = json["title"],
      recipeRecipe = json["recipe"],
      imagePath = json["imagePath"],
      favourite = json["favourite"] as bool,
      id = json["id"] as int;
}