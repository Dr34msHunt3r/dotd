import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotd/cubit/recipes_cubit.dart';
import 'package:dotd/data/repository.dart';
import 'package:meta/meta.dart';

part 'add_recipe_state.dart';

class AddRecipeCubit extends Cubit<AddRecipeState> {
  AddRecipeCubit({required this.recipesCubit, required this.repository}) : super(AddRecipeInitial());

  final Repository repository;
  final RecipesCubit recipesCubit;

  void addRecipe(String recipeTitle, String recipeRecipe) {
    if (recipeTitle.isEmpty){
      emit(AddRecipeError(error: "recipe title is empty"));
      return;
    }else if (recipeRecipe.isEmpty){
      emit(AddRecipeError(error: "recipe is empty"));
      return;
    }
    emit(AddingRecipe());
    Timer(const Duration(seconds: 2), () {
      repository.addRecipe(recipeTitle, recipeRecipe).then((recipe) {
        if(recipe != null){
          recipesCubit.addRecipe(recipe);
        }
      });
    });
  }
}
