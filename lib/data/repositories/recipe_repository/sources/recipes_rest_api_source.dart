import 'dart:convert';

import 'package:dotd/data/models/recipe_model/recipe_model.dart';
import 'package:dotd/data/network_services/recipe_network_service.dart';
import 'package:dotd/data/repositories/recipe_repository/recipe_repository_helpers.dart';
import 'package:dotd/data/repositories/recipe_repository/sources/source.dart';

class RecipeRestApiSource implements Source {

  final RecipeNetworkService _recipeNetworkService = RecipeNetworkService();

  @override
  Future<List<Recipe>> loadRecipes() async{
    final recipesRaw = await _recipeNetworkService.fetchRecipes();
    return recipesRaw.map((e) => Recipe.fromJson(e)).toList();
  }

  @override
  Future<Recipe> addRecipe(Recipe recipe) async{
    final recipeObj = jsonEncode(recipe.toJson());
    final recipeMap = await _recipeNetworkService.addRecipe(recipeObj);
    if(recipeObj == null || recipeMap == null) {
      return throwExceptionObject();
    }
    return Recipe.fromJson(recipeMap);
  }

  @override
  Future<bool> deleteRecipe(String recipesId) async{
    return await _recipeNetworkService.deleteRecipe(recipesId);
  }

  @override
  Future<bool> updateRecipe(Recipe updatedRecipe) async{
    return await _recipeNetworkService.putRecipe(jsonEncode(updatedRecipe.toJson()));
  }

}