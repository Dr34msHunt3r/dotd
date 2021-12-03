class Ingredient {

  Ingredient({
    this.id ="",
    this.recipeId="",
    required this.name
  });

  String id;
  String recipeId;
  String name;

  Ingredient.fromJson(Map json) :
      id = json["id"],
      recipeId = json["recipeId"],
      name = json["name"];

  Map toJson() => {
    'recipeId' : recipeId,
    'name' : name
  };
}

class IngredientsList {
  IngredientsList(this.ingredients);

  List<Ingredient> ingredients;

  Map<String, dynamic> toJson() => <String, dynamic> {
    "ingredients" : ingredients
  };

}