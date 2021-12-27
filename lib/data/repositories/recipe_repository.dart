import 'dart:convert';
import 'package:dotd/data/network_services/recipe_drift_database/recipe_drift_database.dart';
import 'package:dotd/data/network_services/recipe_network_service.dart';
import 'package:dotd/flavor_config.dart';
import 'package:drift/drift.dart';

import '../models/recipe_model/recipe_model.dart';

class RecipeRepository {
  RecipeRepository({ required this.appDatabase, required this.networkService});

  final RecipeNetworkService networkService;
  final AppDatabase appDatabase;


  Future<List<Recipe>> fetchRecipes() async {
    if(FlavorConfig.instance.values.source == 'MOOR'){
      final recipeList = appDatabase.getAllRecipes();
      print(recipeList);
      return [];
    }else{
      final recipesRaw = await networkService.fetchRecipes();
      return recipesRaw.map((e) => Recipe.fromJson(e)).toList();
    }
  }

  Future<Recipe> addRecipe(Recipe recipe) async {
    if(FlavorConfig.instance.values.source == 'MOOR'){
      final database = AppDatabase();
      database.insertRecipe(RecipesMoorCompanion(
        recipeTitle: Value(recipe.recipeTitle),
        recipeRecipe: Value(recipe.recipeRecipe),
        imageUrl: Value(recipe.imageUrl),
        favourite: Value(recipe.favourite)
      ));
      return Recipe(
        recipeTitle: "Ups!",
        recipeRecipe: "Something gone wrong :(",
        favourite: "false",
        imageUrl: "assets/default/recipe_default_image.png",
        id: "",
        ingredients: [],
      );
    }else{
      final recipeObj = jsonEncode(recipe.toJson());
      final recipeMap = await networkService.addRecipe(recipeObj);
      if(recipeObj == null || recipeMap == null) {
        return Recipe(
          recipeTitle: "Ups!",
          recipeRecipe: "Something gone wrong :(",
          favourite: "false",
          imageUrl: "assets/default/recipe_default_image.png",
          id: "",
          ingredients: [],
        );
      }
      return Recipe.fromJson(recipeMap);
    }
  }

  Future<bool> deleteRecipe(String id) async{
    return await networkService.deleteRecipe(id);
  }

  Future<bool> updateRecipe( Recipe updatedRecipe) async {
    final putObj = jsonEncode(updatedRecipe.toJson());
    return await networkService.putRecipe(putObj);
  }

}