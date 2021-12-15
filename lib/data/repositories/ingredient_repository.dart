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
    final ingredientsObj = jsonEncode(ingredients);
    if(ingredientsObj == null) {
      return [];
    }
    final ingredientsMap = await networkService.addIngredient(ingredientsObj);

    return ingredientsMap.map((e) => Ingredient.fromJson(e)).toList();
  }

  Future<List<Ingredient>> updateIngredients(List<Ingredient> ingredients, String recipeId) async {
    final putRecipeId = jsonEncode(recipeId);
    final putList = jsonEncode(ingredients);
    if(putList == null){
      return [];
    }
    final ingredientsMap = await networkService.updateIngredients(putList, putRecipeId);
    return ingredientsMap.map((e) => Ingredient.fromJson(e)).toList();
  }


}