class Ingredient {

  Ingredient({
    this.id =0,
    this.recipeId =0,
    required this.name
  });

  int id;
  int recipeId;
  String name;

  Ingredient.fromJson(Map json) :
      id = json["id"] as int,
      recipeId = json["recipeId"] as int,
      name = json["name"];
}