import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotd/data/models/recipe_model.dart';
import 'package:dotd/data/repositories/recipe_repository.dart';
import 'package:meta/meta.dart';

part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit({required this.recipe_repository}) : super(RecipesInitial());

  final RecipeRepository recipe_repository;

  void fetchRecipes() {
    Timer(const Duration(seconds: 1), (){
      recipe_repository.fetchRecipes().then((recipes) {
        if( recipes.isEmpty ){
          emit(RecipesEmpty(recipes: recipes));
          print("Recipes empty");
        } else {
          emit(RecipesLoaded(recipes: recipes));
        }
      });
    });
  }

  void addRecipe(Recipe recipe) {
    final currentState = state;
    if(currentState is RecipesLoaded || currentState is RecipesEmpty){
      final recipeList = currentState.recipes;
      recipeList.add(recipe);
      emit(RecipesLoaded(recipes: recipeList));
    }
  }

  void deleteCubit(Recipe recipe) {
    final currentState = state;
    if(currentState is RecipesLoaded){
      final recipeList = currentState.recipes.where((element) => element.id != recipe.id).toList();
      if (recipeList.isEmpty){
        print("list empty after delete");
        emit(RecipesEmpty(recipes: recipeList));
      }else{
        print("list not empty after delete");
        emit(RecipesLoaded(recipes: recipeList));
      }

    }
  }

  void updateRecipeList() {
    final currentState = state;
    if(currentState is RecipesLoaded){
      emit(RecipesLoaded(recipes: currentState.recipes));
    }

  }
}
