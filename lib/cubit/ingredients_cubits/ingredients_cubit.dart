import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotd/data/models/ingredients.dart';
import 'package:dotd/data/repositories/ingredient_repository.dart';
import 'package:meta/meta.dart';

part 'ingredients_state.dart';

class IngredientsCubit extends Cubit<IngredientsState> {
  IngredientsCubit({required this.ingredient_repository}) : super(IngredientsInitial());

  final IngredientRepository ingredient_repository;

  void fetchIngredients() {
    Timer(const Duration(seconds: 1), (){
      ingredient_repository.fetchIngredients().then((ingredients) {
        emit(IngredientsLoaded(ingredients: ingredients));
      });
    });
  }

  void addIngredient(List<Ingredient> ingredients) {
    final currentState = state;
    if(currentState is IngredientsLoaded){
      var ingredientList = currentState.ingredients;
      ingredientList = ingredientList + ingredients;
      emit(IngredientsLoaded(ingredients: ingredientList));
    }
  }

  void updateIngredientsList(List<Ingredient> ingredients, List<Ingredient> newIngredients, String recipeId) {
    final currentState = state;
    if(currentState is IngredientsLoaded){
      final oldIngredients = currentState.ingredients;
      var oldIngredientsCounter = oldIngredients.length;
      var ingredientsCounter = ingredients.length;
      for(var i=0; i <= oldIngredientsCounter-1; i++){
        if(oldIngredients[i].recipeId == recipeId){
          oldIngredients.removeAt(i);
          oldIngredientsCounter--;
          i--;
        }
        for(var i=0; i <= ingredientsCounter-1; i++) {
          if (ingredients[i].id == '') {
            ingredients.removeAt(i);
            ingredientsCounter--;
            i--;
          }
        }
      }
      final ingredientList = oldIngredients + ingredients + newIngredients;
      emit(IngredientsLoaded(ingredients: ingredientList));
    }
  }
}
