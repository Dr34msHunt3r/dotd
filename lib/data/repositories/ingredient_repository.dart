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

  Future<List<Ingredient>> addIngredients(List <Ingredient> ingredients) async {
    // final IngredientsList ingredientsList = IngredientsList(ingredients);
    final ingredientsObj = jsonEncode(ingredients);
    print(ingredientsObj);
    final ingredientsMap = await networkService.addIngredient(ingredientsObj);
    if(ingredientsObj == null) {
      return [];
    }

    return ingredientsMap.map((e) => Ingredient.fromJson(e)).toList();
  }


}