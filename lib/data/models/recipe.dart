class Recipe {

  Recipe({
  required this.recipeTitle,
  required this.recipeRecipe,
    this.imageUrl = "assets/default/recipe_default_image.png",
    this.favourite = "false",
    this.id = ""
  });

  String recipeTitle;
  String recipeRecipe;
  String imageUrl;
  String favourite;
  String id;

  Recipe.fromJson(Map json) :
      recipeTitle = json["title"],
      recipeRecipe = json["recipe"],
      imageUrl = json["imageUrl"],
      favourite = json["favourite"],
      id = json["id"];
}