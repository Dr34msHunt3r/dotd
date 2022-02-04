import 'package:bloc/bloc.dart';
import 'package:dotd/config/app_strings.dart';
import 'package:dotd/database/custom_rest_api/services/dto/recipe_dto.dart';
import 'package:dotd/repository/recipe_repository/recipe_repository.dart';
import 'package:dotd/screens/recipes_screen/recipes_cubit.dart';
import 'package:meta/meta.dart';

part 'edit_recipe_state.dart';

class EditRecipeCubit extends Cubit<EditRecipeState> {
  EditRecipeCubit({required this.repository, required this.recipesCubit}) : super(EditRecipeInitial());

  final RecipeRepository repository;
  final RecipesCubit recipesCubit;

  void deleteRecipe(Recipe recipe) {
    emit(EditingRecipe());
    repository.deleteRecipe(recipe.id!).then((isDeleted) {
      if(isDeleted){
        recipesCubit.deleteCubit(recipe);
        emit(RecipeEdited());
      }
    });
  }

  void updateRecipe(Recipe updatedRecipe) {
    if (updatedRecipe.recipeTitle.isEmpty){
      emit(EditRecipeError(error: AppStrings.emptyRecipeTitle));
      return;
    }else if(updatedRecipe.recipeRecipe.isEmpty){
      emit(EditRecipeError(error: AppStrings.emptyRecipeBody));
      return;
    }
    emit(EditingRecipe());
    repository.updateRecipe(updatedRecipe).then((isEdited) {
      if(isEdited) {
        recipesCubit.updateRecipeList(updatedRecipe);
        emit(RecipeEdited());
      }
    });
  }

}
