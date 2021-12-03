import 'dart:convert';

import 'package:dotd/data/network_services/ingredient_network_service.dart';

import '../models/ingredients.dart';

class IngredientRepository {
  IngredientRepository({required this.networkService});

  final IngredientNetworkService networkService;

  Future<List<Ingredient>> fetchIngredients() async {
    final ingredientsRaw = await networkService.fetchIngredients();
    return ingredientsRaw.map((e) => Ingredient.fromJson(e)).toList();
  }

  Future<List<Ingredient>> addIngredients(List <Ingredient> ingredients, String recipeId) async {
    final IngredientsList ingredientsList = IngredientsList(ingredients);
    final ingredientsObj = jsonEncode(ingredients);
    // final ingredientsObj = ingredients.map((e) => {"name":e.name, "recipeId": e.recipeId});
    print(ingredientsObj);
    await networkService.addIngredient(ingredientsObj, recipeId);
    if(ingredientsObj == null) {
      return [];
    }

    return [];
      // ingredientsMap.map((e) => Ingredient.fromJson(e)).toList();
  }


}