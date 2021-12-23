import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dotd/cubit/recipe_cubits/recipes_cubit.dart';
import 'package:dotd/data/models/recipe_model/recipe_model.dart';
import 'package:dotd/data/repositories/recipe_repository.dart';
import 'package:meta/meta.dart';

part 'edit_recipe_state.dart';

class EditRecipeCubit extends Cubit<EditRecipeState> {
  EditRecipeCubit({required this.repository, required this.recipesCubit}) : super(EditRecipeInitial());

  final RecipeRepository repository;
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

    repository.updateRecipe(updatedRecipe).then((isEdited) {
      if(isEdited) {
        recipe.recipeTitle = updatedRecipe.recipeTitle;
        recipe.recipeRecipe = updatedRecipe.recipeRecipe;
        recipe.favourite = updatedRecipe.favourite;
        recipe.imageUrl = updatedRecipe.imageUrl;
        recipe.ingredients = updatedRecipe.ingredients;
        recipesCubit.updateRecipeList();
        emit(RecipeEdited());
      }
    });
  }

}
