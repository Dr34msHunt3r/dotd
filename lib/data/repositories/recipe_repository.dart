import 'package:dotd/data/network_services/recipe_network_service.dart';

import '../models/recipe_model.dart';

class RecipeRepository {
  RecipeRepository({required this.networkService});

  final RecipeNetworkService networkService;


  Future<List<Recipe>> fetchRecipes() async {
    final recipesRaw = await networkService.fetchRecipes();
    return recipesRaw.map((e) => Recipe.fromJson(e)).toList();
  }

  Future<Recipe> addRecipe(String recipeTitle, String recipeRecipe) async {
    final recipeObj = Recipe(
        favourite: "false",
        id: "",
        recipeTitle: recipeTitle,
        recipeRecipe: recipeRecipe,
        imageUrl: "assets/default/recipe_default_image.png"
    ).toJson();

    final recipeMap = await networkService.addRecipe(recipeObj);
    if(recipeObj == null) {
      return Recipe(
        recipeTitle: "Ups!",
        recipeRecipe: "Something gone wrong :(",
        favourite: "false",
        imageUrl: "assets/default/recipe_default_image.png",
        id: "",

      );
    }

    return Recipe.fromJson(recipeMap);
  }

  Future<bool> deleteRecipe(String id) async{
    return await networkService.deleteRecipe(id);
  }

  Future<bool> updateRecipe(String id, Recipe updatedRecipe) async {
    final putObj = Recipe(
        favourite: "false",
        id: id,
        recipeTitle: updatedRecipe.recipeTitle,
        recipeRecipe: updatedRecipe.recipeRecipe,
        imageUrl: "assets/default/recipe_default_image.png"
    ).toJson();
    return await networkService.putRecipe(putObj, id);
  }

}