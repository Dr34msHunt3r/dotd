class Recipe {

  Recipe({
  required this.recipeTitle,
  required this.recipeRecipe,
    this.id = 0
  });

  String recipeTitle;
  String recipeRecipe;
  int id;

  Recipe.fromJson(Map json) :
      recipeTitle = json["title"],
      recipeRecipe = json["recipe"],
      id = json["id"] as int;
}