import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotd/analytics/event_reporter.dart';
import 'package:dotd/analytics/firebase_event_reporter.dart';
import 'package:dotd/api/services/dto/recipe_dto.dart';
import 'package:dotd/repository/recipe_repository/recipe_repository.dart';
import 'package:meta/meta.dart';

part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit({required this.recipeRepository, required this.firebaseEventReporter}) : super(RecipesInitial());

  final RecipeRepository recipeRepository;
  final FirebaseEventReporter firebaseEventReporter;

  void fetchRecipes() {
    Timer(const Duration(seconds: 1), (){
      recipeRepository.fetchRecipes().then((recipes) {
        if( recipes.isEmpty ){
          emit(RecipesEmpty(recipes: recipes));
          print("Recipes empty");
          firebaseEventReporter.reportEvent(EventReporter.LOADED_RECIPES_EMPTY_LIST);
        } else {
          emit(RecipesLoaded(recipes: recipes));
          firebaseEventReporter.reportEvent(EventReporter.LOADED_RECIPES_FILLED_LIST);
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
      firebaseEventReporter.reportEvent(EventReporter.ADDED_NEW_RECIPE);
    }
  }

  void deleteCubit(Recipe recipe) {
    final currentState = state;
    if(currentState is RecipesLoaded){
      final recipeList = currentState.recipes.where((element) => element.id != recipe.id).toList();
      firebaseEventReporter.reportEvent(EventReporter.DELETED_RECIPE);
      if (recipeList.isEmpty){
        print("list empty after delete");
        emit(RecipesEmpty(recipes: recipeList));
        firebaseEventReporter.reportEvent(EventReporter.RECIPES_LIST_EMPTY_AFTER_DELETE);
      }else{
        print("list not empty after delete");
        emit(RecipesLoaded(recipes: recipeList));
        firebaseEventReporter.reportEvent(EventReporter.RECIPES_LIST_NOT_EMPTY_AFTER_DELETE);
      }
    }
  }

  void updateRecipeList() {
    final currentState = state;
    if(currentState is RecipesLoaded){
      emit(RecipesLoaded(recipes: currentState.recipes));
      firebaseEventReporter.reportEvent(EventReporter.UPDATED_RECIPE);
    }

  }
}
