import 'package:dotd/data/network_service.dart';

import 'models/recipe.dart';

class Repository {
  Repository({required this.networkService});

  final NetworkService networkService;


  Future<List<Recipe>> fetchRecipes() async {
    final recipesRaw = await networkService.fetchRecipes();
    return recipesRaw.map((e) => Recipe.fromJson(e)).toList();
  }

  Future<Recipe> addRecipe(String recipeTitle, String recipeRecipe) async {
    final recipeObj = {"title": recipeTitle, "recipe": recipeRecipe};

    final recipeMap = await networkService.addRecipe(recipeObj);
    if(recipeObj == null) {
      return Recipe(
        recipeTitle: "Ups!",
        recipeRecipe: "Something gone wrong :(",
      );
    }

    return Recipe.fromJson(recipeMap);
  }

  Future<bool> deleteRecipe(int id) async{
    return await networkService.deleteRecipe(id);
  }

  Future<bool> updateRecipe(int id, Recipe updatedRecipe) async {
    final putObj = {"title": updatedRecipe.recipeTitle, "recipe": updatedRecipe.recipeRecipe};
    return await networkService.putRecipe(putObj, id);
  }

}