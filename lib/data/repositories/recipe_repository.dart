import 'package:dotd/data/network_services/recipe_network_service.dart';

import '../models/recipe.dart';

class RecipeRepository {
  RecipeRepository({required this.networkService});

  final RecipeNetworkService networkService;


  Future<List<Recipe>> fetchRecipes() async {
    final recipesRaw = await networkService.fetchRecipes();
    return recipesRaw.map((e) => Recipe.fromJson(e)).toList();
  }

  Future<Recipe> addRecipe(String recipeTitle, String recipeRecipe) async {
    final recipeObj = {"title": recipeTitle,
      "recipe": recipeRecipe,
      "imageUrl": "assets/default/recipe_default_image.png",
      "favourite": false.toString()
    };

    final recipeMap = await networkService.addRecipe(recipeObj);
    if(recipeObj == null) {
      return Recipe(
        recipeTitle: "Ups!",
        recipeRecipe: "Something gone wrong :(",
      );
    }

    return Recipe.fromJson(recipeMap);
  }

  Future<bool> deleteRecipe(String id) async{
    return await networkService.deleteRecipe(id);
  }

  Future<bool> updateRecipe(String id, Recipe updatedRecipe) async {
    final putObj = {"title": updatedRecipe.recipeTitle,
      "recipe": updatedRecipe.recipeRecipe,
      "imageUrl": "assets/default/recipe_default_image.png",
      "favourite": false.toString(),
      "id": id
    };
    return await networkService.putRecipe(putObj, id);
  }

}