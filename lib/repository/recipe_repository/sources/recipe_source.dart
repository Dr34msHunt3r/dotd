import 'package:dotd/repository/recipe_repository/model/dto/recipe_dto.dart';

abstract class RecipeSource {
  const RecipeSource();

  Future<List<Recipe>> loadRecipes();
  Future<Recipe> addRecipe(Recipe recipe);
  Future<bool> deleteRecipe(Recipe recipe);
  Future<Recipe> updateRecipe(Recipe updatedRecipe);

  static const REST_API = "RESTAPI";
  static const MOOR = "MOOR";
  static const SECURE_STORAGE = "SECURE_STORAGE";
  static const RTDB = "RTDB";
}