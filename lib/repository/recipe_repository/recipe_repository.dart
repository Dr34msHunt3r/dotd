import 'package:dotd/api/model/recipe_model.dart';
import 'package:dotd/extensions/flavor_config.dart';
import 'package:dotd/repository/recipe_repository/sources/recipes_moor_source.dart';
import 'package:dotd/repository/recipe_repository/sources/recipes_rest_api_source.dart';
import 'package:dotd/repository/recipe_repository/sources/recipes_secure_storage_source.dart';
import 'package:dotd/repository/recipe_repository/sources/source.dart';

class RecipeRepository {

  late final Source _source;

  RecipeRepository(){
    switch(FlavorConfig.instance.flavor.name){
      case Source.REST_API:
        _source = RecipeRestApiSource();
        break;
      case Source.MOOR:
        _source = RecipeMoorSource();
        break;
      case Source.SECURE_STORAGE:
        _source = RecipeSecureStorageSource();
        break;
      default: _source = RecipeMoorSource();
    }
  }

  Future<List<Recipe>> fetchRecipes() async {
    return _source.loadRecipes();
  }

  Future<Recipe> addRecipe(Recipe recipe) async {
    return _source.addRecipe(recipe);
  }

  Future<bool> deleteRecipe(String recipesId) async{
    return _source.deleteRecipe(recipesId);
  }

  Future<bool> updateRecipe(Recipe updatedRecipe) async {
    return _source.updateRecipe(updatedRecipe);
  }

}