import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotd/api/services/dto/recipe_dto.dart';
import 'package:dotd/config/app_strings.dart';
import 'package:dotd/repository/recipe_repository/recipe_repository.dart';
import 'package:dotd/screens/recipes_screen/recipes_cubit.dart';
import 'package:meta/meta.dart';

part 'add_recipe_state.dart';

class AddRecipeCubit extends Cubit<AddRecipeState> {
  AddRecipeCubit({required this.recipesCubit, required this.repository}) : super(AddRecipeInitial());

  final RecipeRepository repository;
  final RecipesCubit recipesCubit;

  void addRecipe(Recipe recipe) {
    if (recipe.recipeTitle.isEmpty){
      emit(AddRecipeError(error: AppStrings.emptyRecipeTitle));
      return;
    }else if (recipe.recipeRecipe.isEmpty){
      emit(AddRecipeError(error: AppStrings.emptyRecipeBody));
      return;
    }
    emit(AddingRecipe());
    Timer(const Duration(seconds: 2), () {
      repository.addRecipe(recipe).then((recipe) {
        if(recipe != null){
          recipesCubit.addRecipe(recipe);
          emit(RecipeAdded(recipe: recipe));
        }
      });
    });
  }
}
