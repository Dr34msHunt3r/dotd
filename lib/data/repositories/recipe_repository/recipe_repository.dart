import 'dart:convert';
import 'package:dotd/data/network_services/recipe_drift_database/recipe_drift_database.dart';
import 'package:dotd/data/network_services/recipe_network_service.dart';
import 'package:dotd/data/repositories/recipe_repository/recipe_repository_helpers.dart';
import 'package:dotd/flavor_config.dart';

import '../../models/recipe_model/recipe_model.dart';

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