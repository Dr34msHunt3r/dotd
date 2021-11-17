import 'package:dotd/data/network_service.dart';

import 'models/recipe.dart';

class Repository {
  Repository({required this.networkService});

  final NetworkService networkService;


  Future<List<Recipe>> fetchRecipes() async {
    final recipesRaw = await networkService.fetchRecipes();
    return recipesRaw.map((e) => Recipe.fromJson(e)).toList();
  }

  void addRecipe(String recipeTitle, String recipeRecipe) {}

}