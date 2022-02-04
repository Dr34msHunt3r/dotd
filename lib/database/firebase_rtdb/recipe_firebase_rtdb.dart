import 'package:dotd/database/custom_rest_api/services/dto/recipe_dto.dart';
import 'package:dotd/extensions/recipe_rtbd_converter.dart';
import 'package:firebase_database/firebase_database.dart';

class RecipeRealtimeDatabase {

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _refRecipe = FirebaseDatabase.instance.ref('recipes');

  Future<Recipe> addRecipe(Recipe recipe) async{
    try {
      final key = await _refRecipe.push();
      key.set(recipeToRTDB(recipe, key.key as String));
      await _refRecipe.child(key.key as String).child('ingredients').set(ingredientsToRTDB(recipe.ingredients));
      return await Recipe(
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

  Future<bool> deleteRecipe(String recipesId) async{
    try {
      _refRecipe.child("${recipesId}").remove();
      return true;
    } on Exception catch (e) {
      throw Exception("Firebase Realtime Database unable to delete recipe: ${e}");
    }
  }

  Future<List<Recipe>> loadRecipes() async{
    try {
      final stream = await _refRecipe.once();
      final List<Recipe> _recipeList = [];

      stream.snapshot.children.forEach((event) {
        _recipeList.add(recipeFromRTDB(event.value as dynamic, []));
      });
      return _recipeList;
    } on Exception catch (e) {
      throw Exception("Firebase Realtime Database unable to load recipes: ${e}");
    }
  }

  Future<bool> updateRecipe(Recipe updatedRecipe) async{
    try {
      _refRecipe.child("${updatedRecipe.id}").set(recipeToRTDB(updatedRecipe, null));
      return true;
    } on Exception catch (e) {
      throw Exception("Firebase Realtime Database unable to update recipe: ${e}");
    }
  }

}