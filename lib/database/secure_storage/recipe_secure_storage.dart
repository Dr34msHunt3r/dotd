import 'dart:convert';
import 'package:dotd/extensions/recipe_moor_converter.dart';
import 'package:dotd/repository/recipe_repository/model/dto/recipe_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class RecipeSecureStorage {
  var _uuid = Uuid();

  static final _storage = FlutterSecureStorage();

  List<Recipe> _recipes = [];

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  Future<List<Recipe>> readAll() async {
    try {
      final all = await _storage.readAll(aOptions: _getAndroidOptions());
      _recipes = all.entries
          .map((entry) => Recipe.fromJson(jsonDecode(entry.value)))
          .toList();
      return _recipes;
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  Future<Recipe> writeRecipe(Recipe recipe) async{
    try {
      final _key = _uuid.v4();
      final addedRecipe = Recipe(
        recipeRecipe: recipe.recipeRecipe,
        ingredients: recipe.ingredients,
        recipeTitle: recipe.recipeTitle,
        imageUrl: recipe.imageUrl,
        favourite: recipe.favourite,
        id: _key
      );
      final recipeObj = jsonEncode(addedRecipe.toJson());
      await _storage.write(
          key: _key,
          value: recipeObj,
          aOptions: _getAndroidOptions());
      return addedRecipe;
    } on Exception catch (e) {
      print(e);
      return throwExceptionObject();
    }
  }

  Future<bool> deleteRecipe(String id) async {
    try {
      await _storage.delete(
          key: id,
          aOptions: _getAndroidOptions());
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editRecipe(String putObj, String key) async{
    try {
      await _storage.write(
          key: key,
          value: putObj,
          aOptions: _getAndroidOptions());
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

}