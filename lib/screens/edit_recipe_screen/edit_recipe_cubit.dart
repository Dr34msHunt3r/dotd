import 'package:bloc/bloc.dart';
import 'package:dotd/api/services/dto/recipe_dto.dart';
import 'package:dotd/repository/recipe_repository/recipe_repository.dart';
import 'package:dotd/screens/recipes_screen/recipes_cubit.dart';
import 'package:meta/meta.dart';

part 'edit_recipe_state.dart';

class EditRecipeCubit extends Cubit<EditRecipeState> {
  EditRecipeCubit({required this.repository, required this.recipesCubit}) : super(EditRecipeInitial());

  final RecipeRepository repository;
  final RecipesCubit recipesCubit;

  void deleteRecipe(Recipe recipe) {
    repository.deleteRecipe(recipe.id!).then((isDeleted) {
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
        recipesCubit.updateRecipeList(updatedRecipe);
        emit(RecipeEdited());
      }
    });
  }

}
