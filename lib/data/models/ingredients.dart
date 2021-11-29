class Ingredient {

  Ingredient({
    this.id =0,
    required this.recipeId,
    required this.name
  });

  int id;
  String recipeId;
  String name;

  Ingredient.fromJson(Map json) :
      id = json["id"] as int,
      recipeId = json["recipeId"],
      name = json["name"];
}