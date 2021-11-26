import 'package:dotd/data/network_services/ingredient_network_service.dart';

import '../models/ingredients.dart';

class IngredientRepository {
  IngredientRepository({required this.networkService});

  final IngredientNetworkService networkService;

  Future<List<Ingredient>> fetchIngredients(recipeId) async {
    final ingredientsRaw = await networkService.fetchIngredients(recipeId);
    return ingredientsRaw.map((e) => Ingredient.fromJson(e)).toList();
  }


}