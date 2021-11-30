import 'package:dotd/data/network_services/ingredient_network_service.dart';

import '../models/ingredients.dart';

class IngredientRepository {
  IngredientRepository({required this.networkService});

  final IngredientNetworkService networkService;

  Future<List<Ingredient>> fetchIngredients() async {
    final ingredientsRaw = await networkService.fetchIngredients();
    return ingredientsRaw.map((e) => Ingredient.fromJson(e)).toList();
  }

  Future<Ingredient> addIngredient(String name, String recipeId) async {
    final ingredientObj = {
      "name": name
    };

    final ingredientMap = await networkService.addIngredient(ingredientObj, recipeId);
    if(ingredientObj == null) {
      return Ingredient(
        name: "Ups, something went wrong! :("
      );
    }

    return Ingredient.fromJson(ingredientMap);
  }


}