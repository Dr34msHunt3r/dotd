class Recipe {
  late String recipeTitle;
  late String recipeRecipe;
  late int id;

  Recipe.fromJson(Map json) :
      recipeTitle = json["title"],
      recipeRecipe = json["recipe"],
      id = json["id"] as int;
}