import 'package:dotd/repository/recipe_repository/model/dto/recipe_dto.dart';

Recipe recipeFromRTDB(dynamic data, List<Ingredient> ingredients) {
  return Recipe(
      imageUrl: data['imageUrl'],
      favourite: data['favourite'],
      recipeRecipe: data['recipeRecipe'],
      ingredients: data['ingredients']!=null ? ingredientsFromRTDB(data['ingredients']) : [],
      recipeTitle: data['recipeTitle'],
      id: data['id'] ?? null
  );
}

List<Ingredient> ingredientsFromRTDB(List data) {
  final List<Ingredient> ingredients = [];
  data.forEach((name) {
    ingredients.add(Ingredient(name: name));
  });
  return ingredients;
}

Map<String, dynamic> recipeToRTDB(Recipe recipe, String? id, String? imageUrl) {
  return {
    'imageUrl' : imageUrl ?? recipe.imageUrl,
    'favourite' : recipe.favourite,
    'recipeRecipe' : recipe.recipeRecipe,
    'recipeTitle' : recipe.recipeTitle,
    'id' : id ?? recipe.id
  };
}

List<String> ingredientsToRTDB(List<Ingredient> data) {
  final List<String> ingredients = [];
  data.forEach((ingredient) {
    ingredients.add(ingredient.name);
  });
  return ingredients;
}