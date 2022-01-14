import 'package:dotd/data/models/recipe_model/recipe_model.dart';
import 'package:dotd/data/network_services/recipe_drift_database/recipe_drift_database.dart';
import 'package:dotd/data/repositories/recipe_repository/sources/source.dart';

import '../recipe_repository_helpers.dart';

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
    final RecipeMoor recipeRow = await _appDatabase.recipeMoorDao.insertRecipe(
        toMoorCompanionFromRecipe(recipe)
    );
    // TODO: find a way to return inserted ingredients values from batch
    await _appDatabase.batch((batch) {
      batch.insertAll(
          _appDatabase.ingredientsMoor,
          insertIngredientsList(recipe.ingredients, recipeRow.id)
      );
    });
    return toRecipeFromMoor(recipeRow, recipe.ingredients);
  }

  @override
  Future<bool> deleteRecipe(String recipesId) async{
    if(await _appDatabase.recipeMoorDao.deleteRecipeWhereId(recipesId) == 1
        && await _appDatabase.ingredientMoorDao.deleteIngredientsWhereRecipeId(recipesId) >=0 ){
      return true;
    }else{
      return false;
    }
  }

  @override
  Future<bool> updateRecipe(Recipe updatedRecipe) async{
    if(await _appDatabase.recipeMoorDao.updateRecipe(toMoorFromRecipe(updatedRecipe)) == true
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