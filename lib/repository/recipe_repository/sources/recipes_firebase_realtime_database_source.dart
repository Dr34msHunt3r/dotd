import 'package:dotd/api/services/dto/recipe_dto.dart';
import 'package:dotd/repository/recipe_repository/sources/source.dart';
import 'package:firebase_database/firebase_database.dart';

class RecipeRealtimeDatabaseSource implements Source {

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _ref = FirebaseDatabase.instance.ref('recipes');

  @override
  Future<Recipe> addRecipe(Recipe recipe) async{
    try {
      final key = _ref.push();
      await key.set(recipe.toJson());
      print(key.key);
      return Recipe(
          favourite: recipe.favourite,
          imageUrl: recipe.imageUrl,
          ingredients: recipe.ingredients,
          recipeTitle: recipe.recipeTitle,
          recipeRecipe: recipe.recipeRecipe,
          id: key.key
      );
    } on Exception catch (e) {
      throw Exception("Firebase Realtime Database unable to save recipe: ${e}");
    }
  }

  @override
  Future<bool> deleteRecipe(String recipesId) async{
    try {
      await _ref.child("${recipesId}").remove();
      return true;
    } on Exception catch (e) {
      throw Exception("Firebase Realtime Database unable to delete recipe: ${e}");
    }
  }

  @override
  Future<List<Recipe>> loadRecipes() async{
    try {
      final stream = await _ref.once();
      final List<Recipe> _recipeList = [];

      stream.snapshot.children.forEach((event) {
        final _raw = event.value as dynamic;
        _recipeList.add(Recipe(
            id: event.key as String,
            favourite: _raw['favourite'],
            imageUrl: _raw['imageUrl'],
            ingredients: [],
            recipeTitle: _raw['recipeTitle'],
            recipeRecipe: _raw['recipeRecipe']
        ));
      });
      return _recipeList;
    } on Exception catch (e) {
      throw Exception("Firebase Realtime Database unable to load recipes: ${e}");
    }
  }

  @override
  Future<bool> updateRecipe(Recipe updatedRecipe) async{
    try {
      await _ref.child("${updatedRecipe.id}").set(updatedRecipe.toJson());
      return true;
    } on Exception catch (e) {
      throw Exception("Firebase Realtime Database unable to update recipe: ${e}");
    }
  }

}