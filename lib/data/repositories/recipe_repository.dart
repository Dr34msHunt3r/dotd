import 'dart:convert';

import 'package:dotd/data/network_services/recipe_network_service.dart';

import '../models/recipe_model.dart';

class RecipeRepository {
  RecipeRepository({required this.networkService});

  final RecipeNetworkService networkService;


  Future<List<Recipe>> fetchRecipes() async {
    final recipesRaw = await networkService.fetchRecipes();
    return recipesRaw.map((e) => Recipe.fromJson(e)).toList();
  }

  Future<Recipe> addRecipe(Recipe recipe) async {
    final recipeObj = jsonEncode(recipe.toJson());
    // final recipeObj = recipe.toJson();


    final recipeMap = await networkService.addRecipe(recipeObj);
    if(recipeObj == null || recipeMap == null) {
      return Recipe(
        recipeTitle: "Ups!",
        recipeRecipe: "Something gone wrong :(",
        favourite: "false",
        imageUrl: "assets/default/recipe_default_image.png",
        id: "",
        ingredients: [],
      );
    }

    return Recipe.fromJson(recipeMap);
  }

  Future<bool> deleteRecipe(String id) async{
    return await networkService.deleteRecipe(id);
  }

  Future<bool> updateRecipe( Recipe updatedRecipe) async {
    final putObj = jsonEncode(updatedRecipe.toJson());
    return await networkService.putRecipe(putObj);
  }

}