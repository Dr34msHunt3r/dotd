import 'package:bloc/bloc.dart';
import 'package:dotd/config/app_strings.dart';
import 'package:dotd/repository/recipe_repository/model/dto/recipe_dto.dart';
import 'package:dotd/repository/recipe_repository/recipe_repository.dart';
import 'package:dotd/presentation/screens/recipes_screen/bloc/recipe/recipes_cubit.dart';
import 'package:meta/meta.dart';

part 'edit_recipe_state.dart';

class EditRecipeCubit extends Cubit<EditRecipeState> {
  EditRecipeCubit({required this.repository, required this.recipesCubit}) : super(EditRecipeInitial());

  final RecipeRepository repository;
  final RecipesCubit recipesCubit;

  void deleteRecipe(Recipe recipe) {
    emit(EditingRecipe());
    repository.deleteRecipe(recipe).then((isDeleted) {
      if(isDeleted){
        recipesCubit.deleteRecipe(recipe);
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
    repository.updateRecipe(updatedRecipe).then((recipe) {
        recipesCubit.updateRecipeList(recipe);
        emit(RecipeEdited());
    });
  }

}
