import 'package:dotd/extensions/flavor_config.dart';
import 'package:dotd/repository/recipe_repository/sources/recipes_firebase_realtime_database_source.dart';
import 'package:dotd/repository/recipe_repository/sources/recipes_moor_source.dart';
import 'package:dotd/repository/recipe_repository/sources/recipes_rest_api_source.dart';
import 'package:dotd/repository/recipe_repository/sources/recipes_secure_storage_source.dart';
import 'package:dotd/repository/recipe_repository/sources/recipe_source.dart';

import 'model/dto/recipe_dto.dart';

class RecipeRepository {

  late final RecipeSource _source;

  RecipeRepository(){
    switch(FlavorConfig.instance.flavor.name){
      case RecipeSource.REST_API:
        _source = RecipeRestApiSource();
        break;
      case RecipeSource.MOOR:
        _source = RecipeMoorSource();
        break;
      case RecipeSource.SECURE_STORAGE:
        _source = RecipeSecureStorageSource();
        break;
      case RecipeSource.RTDB:
        _source = RecipeRealtimeDatabaseSource();
        break;
      default: _source = RecipeMoorSource();
    }
  }

  Future<List<Recipe>> fetchRecipes() async {
    return await _source.loadRecipes();
  }

  Future<Recipe> addRecipe(Recipe recipe) async {
    return await _source.addRecipe(recipe);
  }

  Future<bool> deleteRecipe(Recipe recipe) async {
    return await _source.deleteRecipe(recipe);
  }

  Future<bool> updateRecipe(Recipe updatedRecipe) async {
    return await _source.updateRecipe(updatedRecipe);
  }

}