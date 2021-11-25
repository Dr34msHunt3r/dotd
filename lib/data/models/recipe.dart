class Recipe {

  Recipe({
  required this.recipeTitle,
  required this.recipeRecipe,
    this.imagePath = "assets/default/recipe_default_image.png",
    this.favourite = "false",
    this.id = 0
  });

  String recipeTitle;
  String recipeRecipe;
  String imagePath;
  String favourite;
  int id;

  Recipe.fromJson(Map json) :
      recipeTitle = json["title"],
      recipeRecipe = json["recipe"],
      imagePath = json["imagePath"],
      favourite = json["favourite"],
      id = json["id"] as int;
}