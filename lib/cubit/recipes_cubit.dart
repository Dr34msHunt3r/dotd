import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotd/data/models/recipe.dart';
import 'package:dotd/data/repository.dart';
import 'package:meta/meta.dart';

part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit({required this.repository}) : super(RecipesInitial());

  final Repository repository;

  void fetchRecipes() {
    Timer(const Duration(seconds: 1), (){
      repository.fetchRecipes().then((recipes) {
        emit(RecipesLoaded(recipes: recipes));
      });
    });
  }

  void addRecipe(Recipe recipe) {
    final currentState = state;
    if(currentState is RecipesLoaded){
      final recipeList = currentState.recipes;
      recipeList.add(recipe);
      emit(RecipesLoaded(recipes: recipeList));
    }
  }

  void deleteCubit(Recipe recipe) {
    final currentState = state;
    if(currentState is RecipesLoaded){
      final recipeList = currentState.recipes.where((element) => element.id != recipe.id).toList();
      emit(RecipesLoaded(recipes: recipeList));
    }
  }

  void updateRecipeList() {
    final currentState = state;
    if(currentState is RecipesLoaded){
      emit(RecipesLoaded(recipes: currentState.recipes));
    }

  }
}
