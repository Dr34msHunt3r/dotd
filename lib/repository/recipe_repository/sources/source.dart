import 'package:dotd/api/services/dto/recipe_dto.dart';

abstract class Source {
  const Source();

  Future<List<Recipe>> loadRecipes();
  Future<Recipe> addRecipe(Recipe recipe);
  Future<bool> deleteRecipe(String recipesId);
  Future<bool> updateRecipe(Recipe updatedRecipe);

  static const REST_API = "RESTAPI";
  static const MOOR = "MOOR";
  static const SECURE_STORAGE = "SECURE_STORAGE";
  static const RTDB = "RTDB";
}