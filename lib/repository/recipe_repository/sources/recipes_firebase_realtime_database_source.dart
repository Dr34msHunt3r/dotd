import 'package:dotd/database/custom_rest_api/services/dto/recipe_dto.dart';
import 'package:dotd/database/firebase_rtdb/recipe_firebase_rtdb.dart';
import 'package:dotd/repository/recipe_repository/sources/source.dart';

class RecipeRealtimeDatabaseSource implements Source {

  RecipeRealtimeDatabase _recipeRealtimeDatabase = RecipeRealtimeDatabase();

  @override
  Future<Recipe> addRecipe(Recipe recipe) async{
    return await _recipeRealtimeDatabase.addRecipe(recipe);
  }

  @override
  Future<bool> deleteRecipe(Recipe recipe) async{
    return await _recipeRealtimeDatabase.deleteRecipe(recipe.id!);
  }

  @override
  Future<List<Recipe>> loadRecipes() async{
    return await _recipeRealtimeDatabase.loadRecipes();
  }

  @override
  Future<bool> updateRecipe(Recipe updatedRecipe) async{
    return await _recipeRealtimeDatabase.updateRecipe(updatedRecipe);
  }

}