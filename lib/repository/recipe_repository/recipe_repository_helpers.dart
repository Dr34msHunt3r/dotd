import 'package:dotd/api/model/recipe_model.dart';
import 'package:dotd/db/config/recipe_drift_database.dart';
import 'package:drift/drift.dart';

Recipe toRecipeFromMoor(RecipeMoor recipeMoor, List<Ingredient> ingredients){
  return Recipe(
      recipeTitle: recipeMoor.recipeTitle,
      recipeRecipe: recipeMoor.recipeRecipe,
      imageUrl: recipeMoor.imageUrl,
      favourite: recipeMoor.favourite,
      ingredients: ingredients,
      id: recipeMoor.id
  );
}

RecipesMoorCompanion toMoorCompanionFromRecipe(Recipe recipe){
  return RecipesMoorCompanion(
      recipeTitle: Value(recipe.recipeTitle),
      recipeRecipe: Value(recipe.recipeRecipe),
      imageUrl: Value(recipe.imageUrl),
      favourite: Value(recipe.favourite)
  );
}

RecipeMoor toMoorFromRecipe(Recipe recipe){
  return RecipeMoor(
      recipeTitle: recipe.recipeTitle,
      recipeRecipe: recipe.recipeRecipe,
      imageUrl: recipe.imageUrl,
      favourite: recipe.favourite,
      id: recipe.id!
  );
}

List<Ingredient> getCertainIngredientsListForRecipe (String recipeId, List<IngredientMoor> ingredientsList){
  List<Ingredient> ingredients = [];
  for(int i=0; i < ingredientsList.length; i++){
    if(ingredientsList[i].recipeMoorId == recipeId){
      ingredients.add(Ingredient(name: ingredientsList[i].name, id: ingredientsList[i].id, recipeId: ingredientsList[i].recipeMoorId));
    }
  }
  return ingredients;
}

List<IngredientsMoorCompanion> insertIngredientsList(List<Ingredient> ingredients, String recipeId){
  List<IngredientsMoorCompanion> ingredientsMoorCompanion = [];
  for(int i=0; i < ingredients.length; i++){
    ingredientsMoorCompanion.add(IngredientsMoorCompanion.insert(recipeMoorId: recipeId, name: ingredients[i].name));
  }
  return ingredientsMoorCompanion;
}

List<IngredientMoor> replaceIngredientsList(List<Ingredient> ingredients){
  for(int i=0; i < ingredients.length; i++){
    IngredientMoor(name: ingredients[i].name, recipeMoorId: ingredients[i].recipeId!, id: ingredients[i].id!);
  }
  return [];
}

Recipe throwExceptionObject(){
  return Recipe(
    recipeTitle: "Ups!",
    recipeRecipe: "Something gone wrong :(",
    favourite: "false",
    imageUrl: "assets/default/recipe_default_image.png",
    id: "",
    ingredients: [],
  );
}