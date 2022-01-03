import 'dart:convert';
import 'package:dotd/data/network_services/analytics_services.dart';
import 'package:dotd/data/network_services/recipe_drift_database/recipe_drift_database.dart';
import 'package:dotd/data/network_services/recipe_network_service.dart';
import 'package:dotd/flavor_config.dart';
import 'package:drift/drift.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../models/recipe_model/recipe_model.dart';

class RecipeRepository {
  RecipeRepository({ required this.appDatabase, required this.networkService});

  final RecipeNetworkService networkService;
  final AppDatabase appDatabase;

  Future<List<Recipe>> fetchRecipes() async {
    if(FlavorConfig.instance.values.source == 'MOOR'){
      final recipesList = await appDatabase.recipeMoorDao.getAllRecipes();
      final ingredientsList = await appDatabase.ingredientMoorDao.getAllIngredients();
      return recipesList.map((e) =>
          toRecipeFromMoor(e, getCertainIngredientsListForRecipe(e.id, ingredientsList))).toList();
    }else{
      final recipesRaw = await networkService.fetchRecipes();
      return recipesRaw.map((e) => Recipe.fromJson(e)).toList();
    }
  }
  // TODO: this is helper converter from moor to recipe
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
  // TODO: helper converter from recipe to moor companion
  RecipesMoorCompanion toMoorCompanionFromRecipe(Recipe recipe){
    return RecipesMoorCompanion(
        recipeTitle: Value(recipe.recipeTitle),
        recipeRecipe: Value(recipe.recipeRecipe),
        imageUrl: Value(recipe.imageUrl),
        favourite: Value(recipe.favourite)
    );
  }
  // TODO: helper converter from recipe to moor
  RecipeMoor toMoorFromRecipe(Recipe recipe){
    return RecipeMoor(
      recipeTitle: recipe.recipeTitle,
      recipeRecipe: recipe.recipeRecipe,
      imageUrl: recipe.imageUrl,
      favourite: recipe.favourite,
      id: recipe.id!
    );
  }
// TODO: this is helper method, clean it up
  List<Ingredient> getCertainIngredientsListForRecipe (String recipeId, List<IngredientMoor> ingredientsList){
    List<Ingredient> ingredients = [];
    for(int i=0; i < ingredientsList.length; i++){
      if(ingredientsList[i].recipeMoorId == recipeId){
        ingredients.add(Ingredient(name: ingredientsList[i].name, id: ingredientsList[i].id, recipeId: ingredientsList[i].recipeMoorId));
      }
    }
    return ingredients;
  }
  // TODO: another helper method insert ingredients
  List<IngredientsMoorCompanion> insertIngredientsList(List<Ingredient> ingredients, String recipeId){
    List<IngredientsMoorCompanion> ingredientsMoorCompanion = [];
    for(int i=0; i < ingredients.length; i++){
      ingredientsMoorCompanion.add(IngredientsMoorCompanion.insert(recipeMoorId: recipeId, name: ingredients[i].name));
    }
    return ingredientsMoorCompanion;
  }
  // TODO: helper method update ingredients
  List<IngredientMoor> replaceIngredientsList(List<Ingredient> ingredients){
    for(int i=0; i < ingredients.length; i++){
      IngredientMoor(name: ingredients[i].name, recipeMoorId: ingredients[i].recipeId!, id: ingredients[i].id!);
    }
    return [];
  }
  // TODO: helper to throw exception object if something went wrong
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

  Future<Recipe> addRecipe(Recipe recipe) async {
    if(FlavorConfig.instance.values.source == 'MOOR'){
      final RecipeMoor recipeRow = await appDatabase.recipeMoorDao.insertRecipe(
          toMoorCompanionFromRecipe(recipe)
      );
      // TODO: find a way to return inserted ingredients values from batch
      await appDatabase.batch((batch) {
        batch.insertAll(
            appDatabase.ingredientsMoor,
            insertIngredientsList(recipe.ingredients, recipeRow.id)
        );
      });
      return toRecipeFromMoor(recipeRow, recipe.ingredients);
    }else{
      final recipeObj = jsonEncode(recipe.toJson());
      final recipeMap = await networkService.addRecipe(recipeObj);
      if(recipeObj == null || recipeMap == null) {
        return throwExceptionObject();
      }
      return Recipe.fromJson(recipeMap);
    }
  }

  Future<bool> deleteRecipe(String id) async{
    if(FlavorConfig.instance.values.source == 'MOOR'){
      if(await appDatabase.recipeMoorDao.deleteRecipeWhereId(id) == 1
          && await appDatabase.ingredientMoorDao.deleteIngredientsWhereRecipeId(id) >=0 ){
        return true;
      }else{
        return false;
      }
    }else{
      return await networkService.deleteRecipe(id);
    }
  }

  Future<bool> updateRecipe(Recipe updatedRecipe) async {
    if(FlavorConfig.instance.values.source == 'MOOR'){
      if(await appDatabase.recipeMoorDao.updateRecipe(toMoorFromRecipe(updatedRecipe)) == true
      && await appDatabase.ingredientMoorDao.deleteIngredientsWhereRecipeId(updatedRecipe.id!) >= 0){
        await appDatabase.batch((batch) {
          batch.insertAll(
              appDatabase.ingredientsMoor,
              insertIngredientsList(updatedRecipe.ingredients, updatedRecipe.id!)
          );
        });
        return true;
      }else{
        return false;
      }
    }else{
      return await networkService.putRecipe(jsonEncode(updatedRecipe.toJson()));
    }
  }

}