import 'package:bloc/bloc.dart';
import 'package:dotd/config/app_strings.dart';
import 'package:dotd/repository/recipe_repository/model/dto/recipe_dto.dart';
import 'package:dotd/repository/recipe_repository/recipe_repository.dart';
import 'package:dotd/presentation/screens/recipes_screen/recipes_cubit.dart';
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
    // TODO musi zwracać edytowany obiekt bo zmiany są dokonywane bardzo głęboko
    // TODO lub można nadać imageUrl z cache ale nie wiem jak to się odbije na innych źródłach :( po restarcie urle by się już zgadzały
    // TODO lub napisać oddzielny BLoC i Cubity dla obrazu, ale to dużo roboty i nie wiem jak to połączyć później
    // TODO w czym jest problem: nie zadziała w przypadku zmiany url z assets na http czy innej modyfikacji z takiego poziomu
    repository.updateRecipe(updatedRecipe).then((isEdited) {
      if(isEdited) {
        recipesCubit.updateRecipeList(updatedRecipe);
        emit(RecipeEdited());
      }
    });
  }

}
