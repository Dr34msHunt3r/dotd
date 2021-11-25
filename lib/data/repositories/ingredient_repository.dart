import 'package:dotd/data/network_services/ingredient_network_service.dart';

import '../models/ingredient.dart';

class IngredientRepository {
  IngredientRepository({required this.networkService});

  final IngredientNetworkService networkService;

  Future<List<Ingredient>> fetchIngredients() async {
    final ingredientsRaw = await networkService.fetchIngredients();
    return ingredientsRaw.map((e) => Ingredient.fromJson(e)).toList();
  }


}