import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dotd/cubit/recipes_cubit.dart';
import 'package:dotd/data/models/recipe.dart';
import 'package:dotd/data/repository.dart';
import 'package:meta/meta.dart';

part 'edit_recipe_state.dart';

class EditRecipeCubit extends Cubit<EditRecipeState> {
  EditRecipeCubit({required this.repository, required this.recipesCubit}) : super(EditRecipeInitial());

  final Repository repository;
  final RecipesCubit recipesCubit;

  void deleteRecipe(Recipe recipe) {
    repository.deleteRecipe(recipe.id).then((isDeleted) {
      if(isDeleted){
        recipesCubit.deleteCubit(recipe);
        emit(RecipeEdited());
      }
    });
  }

  void updateRecipe(Recipe recipe, Recipe updatedRecipe) {
    if (updatedRecipe.recipeTitle.isEmpty){
      emit(EditRecipeError(error: "Recipe title is empty"));
      return;
    }else if(updatedRecipe.recipeRecipe.isEmpty){
      emit(EditRecipeError(error: "Recipe is empty"));
      return;
    }

    repository.updateRecipe(recipe.id, updatedRecipe).then((isEdited) {
      if(isEdited) {
        recipe.recipeTitle = updatedRecipe.recipeTitle;
        recipe.recipeRecipe = updatedRecipe.recipeRecipe;
        recipesCubit.updateRecipeList();
        emit(RecipeEdited());
      }
    });
  }

}
