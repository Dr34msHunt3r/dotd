part of 'edit_recipe_cubit.dart';

@immutable
abstract class EditRecipeState {}

class EditRecipeInitial extends EditRecipeState {}
class EditRecipeError extends EditRecipeState {
  final String error;

  EditRecipeError({required this.error});

}

class RecipeEdited extends EditRecipeState {}