part of 'add_recipe_cubit.dart';

@immutable
abstract class AddRecipeState {}

class AddRecipeInitial extends AddRecipeState {}
class AddRecipeError extends AddRecipeState {
  final String error;

  AddRecipeError({required this.error});
}

class AddingRecipe extends AddRecipeState {}
class RecipeAdded extends AddRecipeState {}
