import 'package:dotd/config/app_assets.dart';
import 'package:dotd/config/app_errors_messages.dart';
import 'package:dotd/database/drift/config/recipe_drift_database.dart';
import 'package:dotd/extensions/recipe_image_file_manager.dart';
import 'package:dotd/repository/recipe_repository/model/dto/recipe_dto.dart';
import 'package:dotd/repository/recipe_repository/sources/recipe_source.dart';
import 'dart:io';

import '../../../extensions/recipe_moor_converter.dart';

class RecipeMoorSource implements RecipeSource {

  AppDatabase _appDatabase = AppDatabase();
  AppErrorMessages _appErrorMessages = AppErrorMessages();

  @override
  Future<List<Recipe>> loadRecipes() async{
    try {
      final recipesList = await _appDatabase.recipeMoorDao.getAllRecipes();
      final ingredientsList = await _appDatabase.ingredientMoorDao.getAllIngredients();
      return recipesList.map((e) =>
          toRecipeFromMoor(e, getCertainIngredientsListForRecipe(e.id, ingredientsList))).toList();
    } on Exception catch (e) {
      return _appErrorMessages.loadingRecipesError(e);
    }
  }

  @override
  Future<Recipe> addRecipe(Recipe recipe) async{
    try {
      final RecipeMoor recipeRow = await _appDatabase.recipeMoorDao.insertRecipe(
          toMoorCompanionFromRecipe(await setRecipeImage(recipe))
      );
      await _appDatabase.batch((batch) {
        batch.insertAll(
            _appDatabase.ingredientsMoor,
            insertIngredientsList(recipe.ingredients, recipeRow.id)
        );
      });
      return toRecipeFromMoor(recipeRow, recipe.ingredients);
    } on Exception catch (e) {
      return _appErrorMessages.addingRecipeError(e);
    }
  }

  @override
  Future<bool> deleteRecipe(Recipe recipe) async{
    if(recipe.imageUrl != AppAssets.defaultRecipeImage) {
      File(recipe.imageUrl).delete();
    }
    if(await _appDatabase.recipeMoorDao.deleteRecipeWhereId(recipe.id!) == 1
        && await _appDatabase.ingredientMoorDao.deleteIngredientsWhereRecipeId(recipe.id!) >=0 ){
      return true;
    }else{
      return false;
    }
  }

  @override
  Future<Recipe> updateRecipe(Recipe updatedRecipe) async{
    try {
      final Recipe recipe = await setRecipeImage(updatedRecipe);
      if(await _appDatabase.recipeMoorDao.updateRecipe(
          toMoorFromRecipe(recipe)) == true
          && await _appDatabase.ingredientMoorDao.deleteIngredientsWhereRecipeId(
              updatedRecipe.id!) >= 0){
        await _appDatabase.batch((batch) {
          batch.insertAll(
              _appDatabase.ingredientsMoor,
              insertIngredientsList(updatedRecipe.ingredients, updatedRecipe.id!)
          );
        });
      }
      return recipe;
    } on Exception catch (e) {
      return _appErrorMessages.updatingRecipeError(e);
    }
  }

}