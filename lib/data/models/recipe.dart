import 'package:meta/meta.dart';
import 'dart:convert';
class Recipe {

  Recipe({
  required this.recipeTitle,
  required this.recipeRecipe,
    this.id = 0
  });

  final String recipeTitle;
  final String recipeRecipe;
  final int id;

  Recipe.fromJson(Map json) :
      recipeTitle = json["title"],
      recipeRecipe = json["recipe"],
      id = json["id"] as int;
}