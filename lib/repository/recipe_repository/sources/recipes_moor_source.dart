import 'package:dotd/config/app_assets.dart';
import 'package:dotd/database/custom_rest_api/services/dto/recipe_dto.dart';
import 'package:dotd/database/drift/config/recipe_drift_database.dart';
import 'package:dotd/extensions/recipe_image_file_manager.dart';
import 'package:dotd/repository/recipe_repository/sources/source.dart';
import 'dart:io';

import '../../../extensions/recipe_moor_converter.dart';

class RecipeMoorSource implements Source {

  AppDatabase _appDatabase = AppDatabase();

  @override
  Future<List<Recipe>> loadRecipes() async{
    final recipesList = await _appDatabase.recipeMoorDao.getAllRecipes();
    final ingredientsList = await _appDatabase.ingredientMoorDao.getAllIngredients();
    return recipesList.map((e) =>
        toRecipeFromMoor(e, getCertainIngredientsListForRecipe(e.id, ingredientsList))).toList();
  }

  @override
  Future<Recipe> addRecipe(Recipe recipe) async{
    String? imageUrl;
    if(recipe.imageCacheUrl!=null && recipe.imageUrl != recipe.imageCacheUrl) {
      imageUrl =
      await setImage(recipe.imageCacheUrl!, recipe.imageUrl);
    }
    final RecipeMoor recipeRow = await _appDatabase.recipeMoorDao.insertRecipe(
        await toMoorCompanionFromRecipe(recipe, imageUrl)
    );
    await _appDatabase.batch((batch) {
      batch.insertAll(
          _appDatabase.ingredientsMoor,
          insertIngredientsList(recipe.ingredients, recipeRow.id)
      );
    });
    return toRecipeFromMoor(recipeRow, recipe.ingredients);
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
  Future<bool> updateRecipe(Recipe updatedRecipe) async{
    String? imageUrl;
    if(updatedRecipe.imageCacheUrl!=null && updatedRecipe.imageUrl != updatedRecipe.imageCacheUrl) {
      imageUrl =
          await setImage(updatedRecipe.imageCacheUrl!, updatedRecipe.imageUrl);
    }
    if(await _appDatabase.recipeMoorDao.updateRecipe(toMoorFromRecipe(updatedRecipe, imageUrl)) == true
        && await _appDatabase.ingredientMoorDao.deleteIngredientsWhereRecipeId(updatedRecipe.id!) >= 0){
      await _appDatabase.batch((batch) {
        batch.insertAll(
            _appDatabase.ingredientsMoor,
            insertIngredientsList(updatedRecipe.ingredients, updatedRecipe.id!)
        );
      });
      return true;
    }else{
      return false;
    }
  }

}